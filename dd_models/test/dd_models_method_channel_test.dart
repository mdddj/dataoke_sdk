import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dd_models/dd_models_method_channel.dart';

void main() {
  MethodChannelDdModels platform = MethodChannelDdModels();
  const MethodChannel channel = MethodChannel('dd_models');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
