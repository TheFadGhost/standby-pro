import '../domain/standby_models.dart';

class OffsetSnapshot {
  const OffsetSnapshot(this.dx, this.dy);

  static const zero = OffsetSnapshot(0, 0);

  final double dx;
  final double dy;

  @override
  bool operator ==(Object other) {
    return other is OffsetSnapshot && other.dx == dx && other.dy == dy;
  }

  @override
  int get hashCode => Object.hash(dx, dy);
}

class BurnInProtection {
  const BurnInProtection._();

  static OffsetSnapshot offsetForTick(int tick, StandbySettings settings) {
    if (!settings.burnInProtection) return OffsetSnapshot.zero;
    final index = tick % 9;
    final dx = ((index % 3) - 1) * 8.0;
    final dy = ((index ~/ 3) - 1) * 6.0;
    return OffsetSnapshot(dx, dy);
  }
}
