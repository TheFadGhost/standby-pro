import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/burn_in_protection.dart';
import '../../core/night_mode_policy.dart';
import '../../domain/standby_models.dart';
import '../../state/standby_controller.dart';
import 'widgets/clock_faces.dart';
import 'widgets/integration_cards.dart';

class StandbyScreen extends StatefulWidget {
  const StandbyScreen({super.key, this.initialSettings});

  final StandbySettings? initialSettings;

  @override
  State<StandbyScreen> createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
  late final StandbyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StandbyController(
      initialSettings: widget.initialSettings,
      autostartTicker: widget.initialSettings == null,
    );
    if (widget.initialSettings == null) {
      _controller.initialize();
    } else {
      _controller.initializeForTest();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final settings = _controller.settings;
        final theme = settings.theme;
        final offset = BurnInProtection.offsetForTick(
          _controller.burnInTick,
          settings,
        );
        return Scaffold(
          body: ColoredBox(
            color: theme.backgroundColor,
            child: SafeArea(
              minimum: const EdgeInsets.all(18),
              child: Stack(
                children: [
                  _AmbientBackground(settings: settings),
                  Transform.translate(
                    offset: Offset(offset.dx, offset.dy),
                    child: _Dashboard(
                      controller: _controller,
                      settings: settings,
                    ),
                  ),
                  _TopBar(controller: _controller),
                  _QuickControls(controller: _controller),
                  if (NightModePolicy.shouldTint(_controller.now, settings))
                    IgnorePointer(
                      child: ColoredBox(
                        color: Colors.red.withValues(
                          alpha: 0.18 * settings.nightTintIntensity,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.controller, required this.settings});

  final StandbyController controller;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    if (settings.layoutMode == StandbyLayoutMode.single) {
      return Center(
        child: _WidgetSurface(
          child: _buildWidget(settings.leftWidget, expanded: true),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 700;
        final children = [
          Expanded(
            child: _WidgetSurface(
              child: _buildWidget(settings.leftWidget, expanded: true),
            ),
          ),
          const SizedBox(width: 14, height: 14),
          Expanded(
            child: _WidgetSurface(
              child: _buildWidget(settings.rightWidget, expanded: true),
            ),
          ),
        ];
        return Padding(
          padding: EdgeInsets.only(
            top: 54,
            left: 4,
            right: 4,
            bottom: isCompact ? 86 : 76,
          ),
          child: isCompact
              ? Column(children: children)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
        );
      },
    );
  }

  Widget _buildWidget(StandbyWidgetType type, {required bool expanded}) {
    return switch (type) {
      StandbyWidgetType.clock => ClockFace(
        time: controller.now,
        settings: settings,
      ),
      StandbyWidgetType.weather => WeatherCard(
        snapshot: controller.snapshots.weather,
        settings: settings,
        isLive: controller.weatherIsLive,
      ),
      StandbyWidgetType.calendar => CalendarCard(
        snapshot: controller.snapshots.calendar,
        settings: settings,
        now: controller.now,
      ),
      StandbyWidgetType.music => MusicCard(
        snapshot: controller.snapshots.nowPlaying,
        settings: settings,
        onCommand: controller.sendMediaCommand,
      ),
    };
  }
}

class _WidgetSurface extends StatelessWidget {
  const _WidgetSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.62),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.075)),
        ),
        child: Padding(padding: const EdgeInsets.all(22), child: child),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.controller});

  final StandbyController controller;

  @override
  Widget build(BuildContext context) {
    final settings = controller.settings;
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Text(
            'Standby Pro',
            style: TextStyle(
              color: settings.theme.foregroundColor.withValues(alpha: 0.9),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: settings.theme.accentColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              settings.theme.name,
              style: TextStyle(
                color: settings.theme.accentColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
          ),
          const Spacer(),
          Icon(
            settings.keepAwakeWhileCharging
                ? Icons.battery_charging_full
                : Icons.battery_3_bar,
            color: settings.theme.foregroundColor.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

class _QuickControls extends StatelessWidget {
  const _QuickControls({required this.controller});

  final StandbyController controller;

  @override
  Widget build(BuildContext context) {
    final settings = controller.settings;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ControlButton(
              label: settings.layoutMode == StandbyLayoutMode.duo
                  ? 'Single'
                  : 'Duo',
              icon: settings.layoutMode == StandbyLayoutMode.duo
                  ? Icons.fullscreen
                  : Icons.view_week,
              onPressed: controller.toggleLayout,
            ),
            _ControlButton(
              label: 'Style',
              icon: Icons.palette_outlined,
              onPressed: controller.cycleTheme,
            ),
            _ControlButton(
              label: 'Clock',
              icon: Icons.schedule,
              onPressed: controller.cycleClockStyle,
            ),
            _ControlButton(
              label: 'Customize',
              icon: Icons.tune,
              onPressed: () => _showCustomization(context, controller),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground({required this.settings});

  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    final theme = settings.theme;
    return Positioned.fill(child: CustomPaint(painter: _AmbientPainter(theme)));
  }
}

class _AmbientPainter extends CustomPainter {
  _AmbientPainter(this.theme);

  final ThemePreset theme;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme.backgroundColor,
          Color.lerp(theme.backgroundColor, theme.secondaryColor, 0.22)!,
          Colors.black,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint);

    final accent = Paint()
      ..color = theme.accentColor.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < 9; i++) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width * (0.12 + i * 0.09), size.height * 0.14),
          radius: 90 + i * 26,
        ),
        math.pi * 0.15,
        math.pi * 0.9,
        false,
        accent,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientPainter oldDelegate) {
    return oldDelegate.theme.id != theme.id;
  }
}

void _showCustomization(BuildContext context, StandbyController controller) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF09090B),
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.9,
    ),
    showDragHandle: true,
    builder: (context) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final settings = controller.settings;
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                const Text(
                  'Customize',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 18),
                _EnumPicker<StandbyWidgetType>(
                  label: 'Left widget',
                  value: settings.leftWidget,
                  values: StandbyWidgetType.values,
                  display: _widgetLabel,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(leftWidget: value),
                  ),
                ),
                _EnumPicker<StandbyWidgetType>(
                  label: 'Right widget',
                  value: settings.rightWidget,
                  values: StandbyWidgetType.values,
                  display: _widgetLabel,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(rightWidget: value),
                  ),
                ),
                _EnumPicker<ClockStyle>(
                  label: 'Clock face',
                  value: settings.clockStyle,
                  values: ClockStyle.values,
                  display: _clockLabel,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(clockStyle: value),
                  ),
                ),
                _SliderRow(
                  label: 'Text size',
                  value: settings.fontScale,
                  min: 0.76,
                  max: 1.28,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(fontScale: value),
                  ),
                ),
                _SliderRow(
                  label: 'Glow',
                  value: settings.glowIntensity,
                  min: 0,
                  max: 0.9,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(glowIntensity: value),
                  ),
                ),
                _SliderRow(
                  label: 'Dim',
                  value: settings.brightness,
                  min: 0.08,
                  max: 1,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(brightness: value),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.showSeconds,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(showSeconds: value),
                  ),
                  title: const Text('Show seconds'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.nightModeEnabled,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(nightModeEnabled: value),
                  ),
                  title: const Text('Night mode tint'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.burnInProtection,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(burnInProtection: value),
                  ),
                  title: const Text('OLED burn-in protection'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.keepAwakeWhileCharging,
                  onChanged: (value) => controller.updateSettings(
                    settings.copyWith(keepAwakeWhileCharging: value),
                  ),
                  title: const Text('Keep awake while charging'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _EnumPicker<T> extends StatelessWidget {
  const _EnumPicker({
    required this.label,
    required this.value,
    required this.values,
    required this.display,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> values;
  final String Function(T value) display;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: SegmentedButton<T>(
              showSelectedIcon: false,
              segments: [
                for (final option in values)
                  ButtonSegment<T>(value: option, label: Text(display(option))),
              ],
              selected: {value},
              onSelectionChanged: (selected) => onChanged(selected.first),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

String _widgetLabel(StandbyWidgetType type) {
  return switch (type) {
    StandbyWidgetType.clock => 'Clock',
    StandbyWidgetType.weather => 'Weather',
    StandbyWidgetType.calendar => 'Calendar',
    StandbyWidgetType.music => 'Audio',
  };
}

String _clockLabel(ClockStyle style) {
  return switch (style) {
    ClockStyle.digital => 'Digital',
    ClockStyle.analog => 'Analog',
    ClockStyle.flip => 'Flip',
    ClockStyle.text => 'Text',
  };
}
