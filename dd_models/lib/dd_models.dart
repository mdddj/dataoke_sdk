
import 'dd_models_platform_interface.dart';

class DdModels {
  Future<String?> getPlatformVersion() {
    return DdModelsPlatform.instance.getPlatformVersion();
  }
}
