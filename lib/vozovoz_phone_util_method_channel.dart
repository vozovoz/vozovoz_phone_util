import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'entity/phone_data_entity.dart';
import 'vozovoz_phone_util_platform_interface.dart';

/// An implementation of [VozovozPhoneUtilPlatform] that uses method channels.
class MethodChannelVozovozPhoneUtil extends VozovozPhoneUtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('vozovoz_phone_util');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<PhoneDataEntity> parse(String phoneNumberString,
      [String? regionCode]) async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
      'parse',
      {
        'string': phoneNumberString,
        'region': regionCode,
      },
    );

    if (result == null) {
      throw PlatformException(
        code: 'PARSE_FAILED',
        message: 'Parsing the phone number returned null',
      );
    }

    return PhoneDataEntity.fromJson(result);
  }
}
