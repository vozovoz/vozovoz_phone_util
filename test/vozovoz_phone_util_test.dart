import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:vozovoz_phone_util/vozovoz_phone_util.dart';
import 'package:vozovoz_phone_util/vozovoz_phone_util_method_channel.dart';
import 'package:vozovoz_phone_util/vozovoz_phone_util_platform_interface.dart';

class MockVozovozPhoneUtilPlatform
    with MockPlatformInterfaceMixin
    implements VozovozPhoneUtilPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VozovozPhoneUtilPlatform initialPlatform =
      VozovozPhoneUtilPlatform.instance;

  test('$MethodChannelVozovozPhoneUtil is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVozovozPhoneUtil>());
  });

  test('getPlatformVersion', () async {
    VozovozPhoneUtil vozovozPhoneUtilPlugin = VozovozPhoneUtil();
    MockVozovozPhoneUtilPlatform fakePlatform = MockVozovozPhoneUtilPlatform();
    VozovozPhoneUtilPlatform.instance = fakePlatform;

    expect(await vozovozPhoneUtilPlugin.getPlatformVersion(), '42');
  });
}
