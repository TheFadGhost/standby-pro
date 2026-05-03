# Project Memory: Standby Mode App

## State Matrix
- **Overall Progress:** 82%
- **Current Phase:** Flutter core rebuild implemented and locally verified
- **Primary Blocker:** iOS device build/signing requires macOS and Xcode; Android device UX still needs hands-on testing.
- **Next Immediate Action:** Test `app/build/app/outputs/flutter-apk/app-debug.apk` on a real Android phone and tune the standby UX from device feedback.

## Key Architecture & Decisions
- Tech Stack: Flutter + Dart with generated Android/iOS projects.
- Android Package: `com.ytchannel.standbypro`.
- Core Engine: Adaptive clock cadence, OLED burn-in offsets, night mode tint policy, native keep-awake/brightness/media channel.
- Integrations: Calendar/weather/music have useful fallback states; Android media commands use a native MethodChannel.
- Product Direction: Inspired original StandBy experience, not a literal clone; no ads or in-app purchases in the first build.

## Recent Actions (Max 3)
1. Replaced the broken Capacitor/React app with a clean Flutter project in `app`.
2. Implemented StandBy UI, Duo/single layouts, clocks, widget panels, customization sheet, persistence models, and performance policies.
3. Verified `flutter test`, `flutter analyze`, and Android debug APK build using Android Studio JBR.
