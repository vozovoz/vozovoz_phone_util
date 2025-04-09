import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vozovoz_phone_util/vozovoz_phone_util_method_channel.dart';

void main() {
  MethodChannelVozovozPhoneUtil platform = MethodChannelVozovozPhoneUtil();
  const MethodChannel channel = MethodChannel('vozovoz_phone_util');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (message) async {
      return '42';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (message) async {
      return null;
    });
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
