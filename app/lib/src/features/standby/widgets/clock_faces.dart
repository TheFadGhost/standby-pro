import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../domain/standby_models.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({super.key, required this.time, required this.settings});

  final DateTime time;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    return switch (settings.clockStyle) {
      ClockStyle.digital => DigitalClockFace(time: time, settings: settings),
      ClockStyle.analog => AnalogClockFace(time: time, settings: settings),
      ClockStyle.flip => FlipClockFace(time: time, settings: settings),
      ClockStyle.text => TextClockFace(time: time, settings: settings),
    };
  }
}

class DigitalClockFace extends StatelessWidget {
  const DigitalClockFace({
    super.key,
    required this.time,
    required this.settings,
  });

  final DateTime time;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    final theme = settings.theme;
    final value = _formattedTime(time, settings);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        value,
        maxLines: 1,
        style: TextStyle(
          color: theme.foregroundColor,
          fontSize: 152 * settings.fontScale,
          height: 0.88,
          fontWeight: FontWeight.lerp(
            FontWeight.w500,
            FontWeight.w900,
            settings.fontWeight / 900,
          ),
          letterSpacing: 0,
          shadows: _glow(theme.accentColor, settings.glowIntensity),
        ),
      ),
    );
  }
}

class FlipClockFace extends StatelessWidget {
  const FlipClockFace({super.key, required this.time, required this.settings});

  final DateTime time;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    final hour = _twoDigits(
      settings.use24HourTime
          ? time.hour
          : (time.hour % 12 == 0 ? 12 : time.hour % 12),
    );
    final minute = _twoDigits(time.minute);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Flip',
          style: TextStyle(
            color: settings.theme.accentColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FlipUnit(value: hour, settings: settings),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                ':',
                style: TextStyle(
                  color: settings.theme.foregroundColor.withValues(alpha: 0.55),
                  fontSize: 86,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            _FlipUnit(value: minute, settings: settings),
          ],
        ),
      ],
    );
  }
}

class _FlipUnit extends StatelessWidget {
  const _FlipUnit({required this.value, required this.settings});

  final String value;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 142,
      height: 174,
      decoration: BoxDecoration(
        color: const Color(0xFF111116),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        boxShadow: [
          BoxShadow(
            color: settings.theme.accentColor.withValues(alpha: 0.18),
            blurRadius: 26,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: settings.theme.foregroundColor,
              fontSize: 92,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(height: 1, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class TextClockFace extends StatelessWidget {
  const TextClockFace({super.key, required this.time, required this.settings});

  final DateTime time;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    final hour = settings.use24HourTime
        ? time.hour
        : (time.hour % 12 == 0 ? 12 : time.hour % 12);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_numberWord(hour), style: _textStyle(settings, 72)),
        Text(
          _numberWord(time.minute),
          style: _textStyle(
            settings,
            56,
          ).copyWith(color: settings.theme.secondaryColor),
        ),
      ],
    );
  }
}

class AnalogClockFace extends StatelessWidget {
  const AnalogClockFace({
    super.key,
    required this.time,
    required this.settings,
  });

  final DateTime time;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _AnalogClockPainter(time, settings),
        child: const SizedBox.square(dimension: 310),
      ),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  _AnalogClockPainter(this.time, this.settings);

  final DateTime time;
  final StandbySettings settings;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final theme = settings.theme;
    final tickPaint = Paint()
      ..color = theme.foregroundColor.withValues(alpha: 0.62)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final accentPaint = Paint()
      ..color = theme.accentColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 60; i++) {
      final angle = (i / 60) * math.pi * 2;
      final inner = radius - (i % 5 == 0 ? 26 : 14);
      final outer = radius - 4;
      canvas.drawLine(
        center + Offset(math.sin(angle) * inner, -math.cos(angle) * inner),
        center + Offset(math.sin(angle) * outer, -math.cos(angle) * outer),
        tickPaint..strokeWidth = i % 5 == 0 ? 4 : 1.4,
      );
    }

    final hour = (time.hour % 12 + time.minute / 60) / 12;
    final minute = (time.minute + time.second / 60) / 60;
    _hand(canvas, center, radius * 0.42, hour, accentPaint..strokeWidth = 8);
    _hand(canvas, center, radius * 0.68, minute, tickPaint..strokeWidth = 5);
    canvas.drawCircle(center, 7, Paint()..color = theme.accentColor);
  }

  void _hand(
    Canvas canvas,
    Offset center,
    double length,
    double turn,
    Paint p,
  ) {
    final angle = turn * math.pi * 2;
    canvas.drawLine(
      center,
      center + Offset(math.sin(angle) * length, -math.cos(angle) * length),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant _AnalogClockPainter oldDelegate) {
    return oldDelegate.time.minute != time.minute ||
        oldDelegate.settings != settings;
  }
}

String _formattedTime(DateTime time, StandbySettings settings) {
  final hour = settings.use24HourTime
      ? time.hour
      : (time.hour % 12 == 0 ? 12 : time.hour % 12);
  final base = '${_twoDigits(hour)}:${_twoDigits(time.minute)}';
  if (!settings.showSeconds) return base;
  return '$base:${_twoDigits(time.second)}';
}

String _twoDigits(int value) => value.toString().padLeft(2, '0');

TextStyle _textStyle(StandbySettings settings, double size) {
  return TextStyle(
    color: settings.theme.foregroundColor,
    fontSize: size,
    fontWeight: FontWeight.w900,
    height: 0.95,
    letterSpacing: 0,
  );
}

List<Shadow> _glow(Color color, double amount) {
  if (amount <= 0.01) return const [];
  return [
    Shadow(
      color: color.withValues(alpha: amount),
      blurRadius: 28 * amount,
    ),
  ];
}

String _numberWord(int value) {
  const words = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];
  if (value < 20) return words[value];
  const tens = {20: 'twenty', 30: 'thirty', 40: 'forty', 50: 'fifty'};
  final ten = value ~/ 10 * 10;
  final rest = value % 10;
  return rest == 0 ? tens[ten]! : '${tens[ten]} ${words[rest]}';
}
