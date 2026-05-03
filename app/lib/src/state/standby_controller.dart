import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/clock_cadence.dart';
import '../data/settings_repository.dart';
import '../domain/standby_models.dart';
import '../services/standby_system_service.dart';
import '../services/weather_service.dart';

class StandbyController extends ChangeNotifier with WidgetsBindingObserver {
  StandbyController({
    StandbySettings? initialSettings,
    IntegrationSnapshotBundle? snapshots,
    SettingsRepository? settingsRepository,
    StandbySystemService? systemService,
    WeatherService? weatherService,
    bool autostartTicker = true,
  }) : settings = initialSettings ?? const StandbySettings(),
       snapshots =
           snapshots ?? IntegrationSnapshotBundle.fallback(now: DateTime.now()),
       _settingsRepository = settingsRepository,
       _systemService = systemService ?? StandbySystemService(),
       _weatherService = weatherService ?? WeatherService(),
       _autostartTicker = autostartTicker,
       now = DateTime.now();

  StandbySettings settings;
  IntegrationSnapshotBundle snapshots;
  DateTime now;
  bool appVisible = true;
  int burnInTick = 0;
  bool weatherIsLive = false;

  final SettingsRepository? _settingsRepository;
  final StandbySystemService _systemService;
  final WeatherService _weatherService;
  final bool _autostartTicker;
  Timer? _timer;

  Future<void> initialize() async {
    WidgetsBinding.instance.addObserver(this);
    final repository =
        _settingsRepository ??
        SettingsRepository(await SharedPreferences.getInstance());
    settings = await repository.load();
    await _applySystemSettings();
    unawaited(refreshWeather());
    if (_autostartTicker) _scheduleNextTick();
    notifyListeners();
  }

  void initializeForTest() {
    if (_autostartTicker) _scheduleNextTick();
  }

  Future<void> refreshWeather() async {
    try {
      final weather = await _weatherService.fetchLondonWeather();
      snapshots = IntegrationSnapshotBundle(
        weather: weather,
        calendar: snapshots.calendar,
        nowPlaying: snapshots.nowPlaying,
      );
      weatherIsLive = true;
      notifyListeners();
    } catch (_) {
      weatherIsLive = false;
    }
  }

  Future<void> updateSettings(StandbySettings value) async {
    settings = value;
    final preferences = await SharedPreferences.getInstance();
    await SettingsRepository(preferences).save(value);
    await _applySystemSettings();
    notifyListeners();
  }

  void toggleLayout() {
    final next = settings.layoutMode == StandbyLayoutMode.duo
        ? StandbyLayoutMode.single
        : StandbyLayoutMode.duo;
    unawaited(updateSettings(settings.copyWith(layoutMode: next)));
  }

  void cycleTheme() {
    final index = standbyThemes.indexWhere(
      (theme) => theme.id == settings.activeThemeId,
    );
    final next = standbyThemes[(index + 1) % standbyThemes.length];
    unawaited(updateSettings(settings.copyWith(activeThemeId: next.id)));
  }

  void cycleClockStyle() {
    final styles = ClockStyle.values;
    final next = styles[(settings.clockStyle.index + 1) % styles.length];
    unawaited(updateSettings(settings.copyWith(clockStyle: next)));
  }

  Future<bool> sendMediaCommand(String command) {
    return _systemService.mediaCommand(command);
  }

  Future<void> _applySystemSettings() async {
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await _systemService.setKeepAwake(settings.keepAwakeWhileCharging);
    await _systemService.setBrightness(settings.brightness);
  }

  void _scheduleNextTick() {
    _timer?.cancel();
    _timer = Timer(
      ClockCadence.nextDelay(now, settings, appVisible: appVisible),
      () {
        now = DateTime.now();
        burnInTick += 1;
        notifyListeners();
        _scheduleNextTick();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appVisible =
        state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive;
    _scheduleNextTick();
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }
}
