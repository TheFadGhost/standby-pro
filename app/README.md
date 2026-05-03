# Standby Pro App

Flutter source for Standby Pro.

## Common Commands

```powershell
C:\Users\AI\flutter\bin\flutter.bat pub get
C:\Users\AI\flutter\bin\flutter.bat test
C:\Users\AI\flutter\bin\flutter.bat analyze
```

For Android builds on this machine, use Android Studio's bundled Java:

```powershell
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:Path="$env:JAVA_HOME\bin;$env:Path"
C:\Users\AI\flutter\bin\flutter.bat build apk --debug
```
