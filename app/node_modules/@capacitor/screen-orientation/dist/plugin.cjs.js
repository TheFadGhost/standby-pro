'use strict';

var core = require('@capacitor/core');

const ScreenOrientation = core.registerPlugin('ScreenOrientation', {
    web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.ScreenOrientationWeb()),
});

class ScreenOrientationWeb extends core.WebPlugin {
    constructor() {
        super();
        if (typeof screen !== 'undefined' && typeof screen.orientation !== 'undefined') {
            screen.orientation.addEventListener('change', () => {
                const type = screen.orientation.type;
                this.notifyListeners('screenOrientationChange', { type });
            });
        }
    }
    async orientation() {
        if (typeof screen === 'undefined' || !screen.orientation) {
            throw this.unavailable('ScreenOrientation API not available in this browser');
        }
        return { type: screen.orientation.type };
    }
    async lock(options) {
        if (typeof screen === 'undefined' ||
            !screen.orientation ||
            !screen.orientation.lock) {
            throw this.unavailable('ScreenOrientation API not available in this browser');
        }
        try {
            await screen.orientation.lock(options.orientation);
        }
        catch (_a) {
            throw this.unavailable('ScreenOrientation API not available in this browser');
        }
    }
    async unlock() {
        if (typeof screen === 'undefined' || !screen.orientation || !screen.orientation.unlock) {
            throw this.unavailable('ScreenOrientation API not available in this browser');
        }
        try {
            screen.orientation.unlock();
        }
        catch (_a) {
            throw this.unavailable('ScreenOrientation API not available in this browser');
        }
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    ScreenOrientationWeb: ScreenOrientationWeb
});

exports.ScreenOrientation = ScreenOrientation;
//# sourceMappingURL=plugin.cjs.js.map
