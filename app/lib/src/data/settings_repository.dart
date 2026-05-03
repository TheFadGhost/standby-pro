import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/standby_models.dart';

class SettingsRepository {
  SettingsRepository(this._preferences);

  static const _settingsKey = 'standby_settings_v1';

  final SharedPreferences _preferences;

  Future<StandbySettings> load() async {
    final raw = _preferences.getString(_settingsKey);
    if (raw == null) return const StandbySettings();
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, Object?>) return const StandbySettings();
    return StandbySettings.fromJson(decoded);
  }

  Future<void> save(StandbySettings settings) async {
    await _preferences.setString(_settingsKey, jsonEncode(settings.toJson()));
  }
}
