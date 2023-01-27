import 'package:flutter_test/flutter_test.dart';
import 'package:dd_models/dd_models.dart';
import 'package:dd_models/dd_models_platform_interface.dart';
import 'package:dd_models/dd_models_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDdModelsPlatform
    with MockPlatformInterfaceMixin
    implements DdModelsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DdModelsPlatform initialPlatform = DdModelsPlatform.instance;

  test('$MethodChannelDdModels is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDdModels>());
  });

  test('getPlatformVersion', () async {
    DdModels ddModelsPlugin = DdModels();
    MockDdModelsPlatform fakePlatform = MockDdModelsPlatform();
    DdModelsPlatform.instance = fakePlatform;

    expect(await ddModelsPlugin.getPlatformVersion(), '42');
  });
}
