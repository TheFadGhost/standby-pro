import 'package:flutter/services.dart';

class StandbySystemService {
  StandbySystemService({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('standby_pro/system');

  final MethodChannel _channel;

  Future<bool> setKeepAwake(bool enabled) async {
    return _invokeBool('setKeepAwake', {'enabled': enabled});
  }

  Future<bool> setBrightness(double value) async {
    return _invokeBool('setBrightness', {'value': value.clamp(0.05, 1.0)});
  }

  Future<bool> mediaCommand(String command) async {
    return _invokeBool('mediaCommand', {'command': command});
  }

  Future<bool> _invokeBool(String method, Map<String, Object> arguments) async {
    try {
      final result = await _channel.invokeMethod<bool>(method, arguments);
      return result ?? false;
    } on MissingPluginException {
      return false;
    } on PlatformException {
      return false;
    }
  }
}
