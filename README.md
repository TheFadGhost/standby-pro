# Standby Pro

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform: Android / iOS](https://img.shields.io/badge/Platform-Android%20%2F%20iOS-blue.svg)](#)
[![Tech: Flutter](https://img.shields.io/badge/Tech-Flutter-02569B.svg)](#)

Standby Pro is an open-source, Flutter-based bedside display for Android and iPhone. It turns a charging phone into a polished always-on clock and widget surface with large readable clock faces, Duo widgets, night mode, and OLED-aware power behavior.

The design is inspired by modern StandBy displays, but uses original layouts, themes, controls, and motion.

## Features

- Single Focus and Duo modes for fullscreen clocks or side-by-side widgets.
- Digital, analog, flip, and text clock faces with themeable typography, size, glow, and brightness.
- Weather, calendar, and music widgets with graceful fallback data when phone permissions or native integrations are unavailable.
- Android media control bridge for play/pause, next, and previous commands.
- Night mode tint for bedside hours, dimming controls, and OLED burn-in pixel shifting.
- Adaptive clock cadence: minute-level updates by default, second-level only when seconds are enabled, and long pauses when the app is backgrounded.
- Generated Android and iOS projects from one Flutter codebase.

## Tech Stack

- Flutter 3.41+ and Dart 3.11+
- Android package id: `com.ytchannel.standbypro`
- Local persistence: `shared_preferences`
- Weather: Open-Meteo HTTP fallback
- Native bridge: Flutter `MethodChannel` named `standby_pro/system`

## Getting Started

### Prerequisites

- Flutter SDK available on your `PATH`.
- Android Studio for Android builds.
- Xcode on macOS for iOS signing and device builds.

### Android

```powershell
cd app
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:Path="$env:JAVA_HOME\bin;$env:Path"
flutter pub get
flutter build apk --debug
```

Open `app/android` in Android Studio if you want the native Android project, or open `app` as the Flutter project.

### Tests

```powershell
cd app
flutter test
flutter analyze
```

## Project Layout

- `app/lib/src/domain`: settings, themes, widget configs, and integration snapshots.
- `app/lib/src/core`: clock cadence, night mode, and OLED burn-in policies.
- `app/lib/src/features/standby`: the main StandBy UI, clock faces, and widget panels.
- `app/lib/src/services`: native system bridge and weather service.
- `app/test`: domain and widget tests for the core behavior.

## iOS Note

The iOS project is generated and kept cross-platform, but this Windows workspace cannot perform final iPhone signing or device validation. Build and signing must be completed on macOS with Xcode.

## License

MIT. See [LICENSE](LICENSE).
