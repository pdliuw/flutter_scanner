import 'dart:async';

import 'package:flutter/services.dart';

class FlutterScanner {
  static const MethodChannel _channel =
      const MethodChannel('flutter_scanner');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get test async {
    final String test = await _channel.invokeMethod('test');
    return test;
  }
}
