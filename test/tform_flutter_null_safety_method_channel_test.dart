import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tform_flutter_null_safety/tform_flutter_null_safety_method_channel.dart';

void main() {
  MethodChannelTformFlutterNullSafety platform = MethodChannelTformFlutterNullSafety();
  const MethodChannel channel = MethodChannel('tform_flutter_null_safety');

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
