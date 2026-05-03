import 'package:flutter/material.dart';
import '../../../domain/standby_models.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.snapshot,
    required this.settings,
    required this.isLive,
  });

  final WeatherSnapshot snapshot;
  final StandbySettings settings;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    final theme = settings.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardLabel(
          icon: Icons.cloud_outlined,
          label: 'Weather',
          settings: settings,
        ),
        const SizedBox(height: 12),
        Text(
          snapshot.city,
          style: TextStyle(
            color: theme.foregroundColor,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${snapshot.temperatureCelsius}°',
            style: TextStyle(
              color: theme.foregroundColor,
              fontSize: 118,
              height: 0.9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ),
        Text(
          '${snapshot.condition}  H:${snapshot.highCelsius}°  L:${snapshot.lowCelsius}°',
          style: TextStyle(
            color: theme.foregroundColor.withValues(alpha: 0.72),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _StatusPill(text: isLive ? 'Live weather' : 'Open-Meteo fallback'),
      ],
    );
  }
}

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.snapshot,
    required this.settings,
    required this.now,
  });

  final CalendarSnapshot snapshot;
  final StandbySettings settings;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = settings.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardLabel(
          icon: Icons.calendar_month,
          label: 'Calendar',
          settings: settings,
        ),
        const SizedBox(height: 18),
        Text(
          _dateLabel(now),
          style: TextStyle(
            color: theme.foregroundColor,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 18),
        ...snapshot.events
            .take(3)
            .map(
              (event) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      '${_hm(event.startsAt)}-${_hm(event.endsAt)}',
                      style: TextStyle(
                        color: theme.foregroundColor.withValues(alpha: 0.62),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

class MusicCard extends StatelessWidget {
  const MusicCard({
    super.key,
    required this.snapshot,
    required this.settings,
    required this.onCommand,
  });

  final NowPlayingSnapshot snapshot;
  final StandbySettings settings;
  final Future<bool> Function(String command) onCommand;

  @override
  Widget build(BuildContext context) {
    final theme = settings.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CardLabel(icon: Icons.graphic_eq, label: 'Music', settings: settings),
        const SizedBox(height: 18),
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [theme.accentColor, theme.secondaryColor],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.accentColor.withValues(alpha: 0.22),
                blurRadius: 34,
              ),
            ],
          ),
          child: const Icon(Icons.album, size: 56, color: Colors.white),
        ),
        const SizedBox(height: 18),
        Text(
          snapshot.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        ),
        Text(
          snapshot.artist,
          style: TextStyle(
            color: theme.foregroundColor.withValues(alpha: 0.64),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: snapshot.progress,
            minHeight: 6,
            backgroundColor: Colors.white.withValues(alpha: 0.15),
            color: theme.accentColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => onCommand('previous'),
              icon: const Icon(Icons.skip_previous),
            ),
            IconButton.filled(
              onPressed: () => onCommand('playPause'),
              icon: Icon(snapshot.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
            IconButton(
              onPressed: () => onCommand('next'),
              icon: const Icon(Icons.skip_next),
            ),
          ],
        ),
        _StatusPill(
          text: snapshot.isControllable ? 'Android media session' : 'Fallback',
        ),
      ],
    );
  }
}

class _CardLabel extends StatelessWidget {
  const _CardLabel({
    required this.icon,
    required this.label,
    required this.settings,
  });

  final IconData icon;
  final String label;
  final StandbySettings settings;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: settings.theme.accentColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: settings.theme.foregroundColor.withValues(alpha: 0.78),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
      ),
    );
  }
}

String _dateLabel(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return '${weekdays[value.weekday - 1]}, ${months[value.month - 1]} ${value.day}';
}

String _hm(DateTime value) {
  return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
