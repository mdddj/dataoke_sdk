
import 'dart:async';

import 'package:flutter/services.dart';

class DataokeSdk {
  static const MethodChannel _channel = MethodChannel('dataoke_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
