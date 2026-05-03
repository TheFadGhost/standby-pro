import '../domain/standby_models.dart';

class NightModePolicy {
  const NightModePolicy._();

  static bool shouldTint(DateTime now, StandbySettings settings) {
    if (!settings.nightModeEnabled) return false;
    return now.hour >= 20 || now.hour < 7;
  }
}
