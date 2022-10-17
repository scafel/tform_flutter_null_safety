import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tform_flutter_null_safety_method_channel.dart';

abstract class TformFlutterNullSafetyPlatform extends PlatformInterface {
  /// Constructs a TformFlutterNullSafetyPlatform.
  TformFlutterNullSafetyPlatform() : super(token: _token);

  static final Object _token = Object();

  static TformFlutterNullSafetyPlatform _instance = MethodChannelTformFlutterNullSafety();

  /// The default instance of [TformFlutterNullSafetyPlatform] to use.
  ///
  /// Defaults to [MethodChannelTformFlutterNullSafety].
  static TformFlutterNullSafetyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TformFlutterNullSafetyPlatform] when
  /// they register themselves.
  static set instance(TformFlutterNullSafetyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
