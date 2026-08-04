# vozovoz_phone_util

Внутренний Flutter-плагин для парсинга, валидации и форматирования телефонных номеров.

Под капотом:

| Платформа | Библиотека |
| --------- | ---------- |
| Android   | [libphonenumber](https://github.com/google/libphonenumber) 9.0.32 |
| iOS       | [PhoneNumberKit](https://github.com/PhoneNumberKit/PhoneNumberKit) 5.0.6 |

## Требования

* Flutter >= 3.38.0, Dart >= 3.10.0
* Android: minSdk 24, compileSdk 36, JDK 17
* iOS: 13.0+

### iOS требует Swift Package Manager

Плагин поставляется **только** как Swift Package — CocoaPods-подспека больше нет,
потому что PhoneNumberKit с версии 5.0 не публикуется в CocoaPods.

В приложении, которое подключает плагин, нужно один раз включить SPM:

```sh
flutter config --enable-swift-package-manager
```

Без этого `flutter pub get` завершится ошибкой
`Plugin vozovoz_phone_util is only Swift Package Manager compatible`.

## Использование

```dart
import 'package:vozovoz_phone_util/index.dart';

final phone = await VozovozPhoneUtil().parse('+79161234567');

print(phone.e164);           // +79161234567
print(phone.national);       // 8 (916) 123-45-67
print(phone.international);  // +7 916 123-45-67
print(phone.regionCode);     // RU
print(phone.countryCode);    // 7
print(phone.type);           // PhoneType.mobile
```

`parse` принимает необязательный `regionCode` для разбора номеров без кода страны:

```dart
await VozovozPhoneUtil().parse('9161234567', regionCode: 'RU');
```

Если номер невалиден, бросается `PlatformException`.
