import { registerPlugin } from '@capacitor/core';
const ScreenOrientation = registerPlugin('ScreenOrientation', {
    web: () => import('./web').then((m) => new m.ScreenOrientationWeb()),
});
export * from './definitions';
export { ScreenOrientation };
//# sourceMappingURL=index.js.map