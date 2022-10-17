import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tform_flutter_null_safety_platform_interface.dart';

/// An implementation of [TformFlutterNullSafetyPlatform] that uses method channels.
class MethodChannelTformFlutterNullSafety extends TformFlutterNullSafetyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tform_flutter_null_safety');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
