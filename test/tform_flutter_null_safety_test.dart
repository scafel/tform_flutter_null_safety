import 'package:flutter_test/flutter_test.dart';
import 'package:tform_flutter_null_safety/tform_flutter_null_safety.dart';
import 'package:tform_flutter_null_safety/tform_flutter_null_safety_platform_interface.dart';
import 'package:tform_flutter_null_safety/tform_flutter_null_safety_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTformFlutterNullSafetyPlatform
    with MockPlatformInterfaceMixin
    implements TformFlutterNullSafetyPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TformFlutterNullSafetyPlatform initialPlatform = TformFlutterNullSafetyPlatform.instance;

  test('$MethodChannelTformFlutterNullSafety is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTformFlutterNullSafety>());
  });

  test('getPlatformVersion', () async {
    TformFlutterNullSafety tformFlutterNullSafetyPlugin = TformFlutterNullSafety();
    MockTformFlutterNullSafetyPlatform fakePlatform = MockTformFlutterNullSafetyPlatform();
    TformFlutterNullSafetyPlatform.instance = fakePlatform;

    expect(await tformFlutterNullSafetyPlugin.getPlatformVersion(), '42');
  });
}
