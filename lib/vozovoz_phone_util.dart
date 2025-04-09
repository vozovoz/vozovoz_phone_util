import 'package:vozovoz_phone_util/entity/phone_data_entity.dart';
import 'package:vozovoz_phone_util/vozovoz_phone_util_method_channel.dart';

import 'vozovoz_phone_util_platform_interface.dart';

class VozovozPhoneUtil {
  final MethodChannelVozovozPhoneUtil _channel =
      MethodChannelVozovozPhoneUtil();

  Future<String?> getPlatformVersion() =>
      VozovozPhoneUtilPlatform.instance.getPlatformVersion();

  Future<PhoneDataEntity> parse(
    String phoneNumberString, {
    String? regionCode,
  }) =>
      _channel.parse(phoneNumberString, regionCode);
}
