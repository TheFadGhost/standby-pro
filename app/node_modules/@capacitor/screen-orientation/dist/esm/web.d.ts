import { WebPlugin } from '@capacitor/core';
import type { OrientationLockOptions, ScreenOrientationPlugin, ScreenOrientationResult } from './definitions';
export declare class ScreenOrientationWeb extends WebPlugin implements ScreenOrientationPlugin {
    constructor();
    orientation(): Promise<ScreenOrientationResult>;
    lock(options: OrientationLockOptions): Promise<void>;
    unlock(): Promise<void>;
}
