import { Device } from '@capacitor/device';
import { ScreenOrientation } from '@capacitor/screen-orientation';

/**
 * ChargingService
 * Handles the detection of the charging state.
 */
export class ChargingService {
  static async isCharging(): Promise<boolean> {
    const info = await Device.getBatteryInfo();
    return info.isCharging ?? false;
  }

  static async watchChargingStatus(callback: (isCharging: boolean) => void) {
    // Note: Some platforms might require a plugin like 'capacitor-battery-status' 
    // for true background/broadcast events, but we can poll or use system events.
    setInterval(async () => {
      const isCharging = await this.isCharging();
      callback(isCharging);
    }, 5000); // Check every 5 seconds
  }
}

/**
 * OrientationManager
 * Handles orientation locks and detection.
 */
export class OrientationManager {
  static async lockLandscape() {
    await ScreenOrientation.lock({ orientation: 'landscape' });
  }

  static async unlock() {
    await ScreenOrientation.unlock();
  }

  static async getCurrentOrientation() {
    return await ScreenOrientation.orientation();
  }
}
