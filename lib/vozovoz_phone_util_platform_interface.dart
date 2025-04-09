import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'vozovoz_phone_util_method_channel.dart';

abstract class VozovozPhoneUtilPlatform extends PlatformInterface {
  /// Constructs a VozovozPhoneUtilPlatform.
  VozovozPhoneUtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static VozovozPhoneUtilPlatform _instance = MethodChannelVozovozPhoneUtil();

  /// The default instance of [VozovozPhoneUtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelVozovozPhoneUtil].
  static VozovozPhoneUtilPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VozovozPhoneUtilPlatform] when
  /// they register themselves.
  static set instance(VozovozPhoneUtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
