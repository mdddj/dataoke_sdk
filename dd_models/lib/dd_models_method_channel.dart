import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dd_models_platform_interface.dart';

/// An implementation of [DdModelsPlatform] that uses method channels.
class MethodChannelDdModels extends DdModelsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dd_models');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
