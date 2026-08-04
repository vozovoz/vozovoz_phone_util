## 0.1.0

**Breaking changes**

* iOS переведён на Swift Package Manager. CocoaPods-подспека удалена — приложение,
  подключающее плагин, обязано включить SPM:
  `flutter config --enable-swift-package-manager`.
* iOS: PhoneNumberKit 4.0.1 → 5.0.6 (репозиторий переехал в организацию
  `PhoneNumberKit`, старый `marmelroy/PhoneNumberKit` заморожен на 4.3.0 и больше
  не публикуется в CocoaPods). Минимальная версия iOS поднята до 13.0.
* Android: minSdk 16 → 24, compileSdk 34 → 36, Java 8 → 17.
* Требования к окружению: Flutter >= 3.38.0, Dart >= 3.10.0
  (прежнее ограничение `sdk: '>=2.18.6 <3.0.0'` не позволяло использовать
  пакет на Dart 3).

**Обновления**

* Android: libphonenumber 9.0.2 → 9.0.32, AGP 8.1.4 → 8.13.2,
  Gradle 8.2 → 8.14.5, Kotlin 1.6.10 → 2.2.20.
* `plugin_platform_interface` → ^2.1.8, `flutter_lints` → ^6.0.0.

## 0.0.1

* Начальный релиз.
