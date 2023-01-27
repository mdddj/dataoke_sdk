import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dd_models_method_channel.dart';

abstract class DdModelsPlatform extends PlatformInterface {
  /// Constructs a DdModelsPlatform.
  DdModelsPlatform() : super(token: _token);

  static final Object _token = Object();

  static DdModelsPlatform _instance = MethodChannelDdModels();

  /// The default instance of [DdModelsPlatform] to use.
  ///
  /// Defaults to [MethodChannelDdModels].
  static DdModelsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DdModelsPlatform] when
  /// they register themselves.
  static set instance(DdModelsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
