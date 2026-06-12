# Standby Pro App

Flutter source for Standby Pro.

## Common Commands

```powershell
flutter pub get
flutter test
flutter analyze
```

For Android builds on this machine, use Android Studio's bundled Java:

```powershell
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:Path="$env:JAVA_HOME\bin;$env:Path"
flutter build apk --debug
```
