import '../domain/standby_models.dart';

class ClockCadence {
  const ClockCadence._();

  static Duration nextDelay(
    DateTime now,
    StandbySettings settings, {
    bool appVisible = true,
  }) {
    if (!appVisible) return const Duration(minutes: 5);

    if (settings.showSeconds) {
      final nextSecond = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second + 1,
      );
      return nextSecond.difference(now);
    }

    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );
    final milliseconds = nextMinute.difference(now).inMilliseconds;
    return Duration(seconds: (milliseconds / 1000).ceil());
  }
}
