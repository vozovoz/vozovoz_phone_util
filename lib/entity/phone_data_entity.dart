import 'phone_type.dart';

class PhoneDataEntity {
  const PhoneDataEntity({
    required this.countryCode,
    required this.regionCode,
    required this.e164,
    required this.national,
    required this.type,
    required this.international,
    required this.nationalNumber,
  });

  final String countryCode;
  final String regionCode;
  final String e164;
  final String national;
  final PhoneType type;
  final String international;
  final String nationalNumber;

  factory PhoneDataEntity.fromJson(Map<String, dynamic> json) {
    return PhoneDataEntity(
        countryCode: json['country_code'],
        regionCode: json['region_code'],
        e164: json['e164'],
        national: json['national'],
        type: _mapStringToPhoneNumberType(json['type']),
        international: json['international'],
        nationalNumber: json['national_number']);
  }

  static PhoneType _mapStringToPhoneNumberType(String? typeStr) {
    switch (typeStr) {
      case 'fixedLine':
        return PhoneType.fixedLine;
      case 'mobile':
        return PhoneType.mobile;
      case 'fixedOrMobile':
        return PhoneType.fixedLineOrMobile;
      case 'tollFree':
        return PhoneType.tollFree;
      case 'premiumRate':
        return PhoneType.premiumRate;
      case 'sharedCost':
        return PhoneType.sharedCost;
      case 'voip':
        return PhoneType.voip;
      case 'personalNumber':
        return PhoneType.personalNumber;
      case 'pager':
        return PhoneType.pager;
      case 'uan':
        return PhoneType.uan;
      case 'voicemail':
        return PhoneType.voicemail;
      case 'notParsed':
        return PhoneType.notParsed;
      case 'unknown':
      default:
        return PhoneType.unknown;
    }
  }

  @override
  int get hashCode =>
      countryCode.hashCode ^
      regionCode.hashCode ^
      e164.hashCode ^
      national.hashCode ^
      type.hashCode ^
      international.hashCode ^
      nationalNumber.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneDataEntity &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode &&
          regionCode == other.regionCode &&
          e164 == other.e164 &&
          national == other.national &&
          type == other.type &&
          international == other.international &&
          nationalNumber == other.nationalNumber;

  @override
  String toString() {
    return 'PhoneNumber { '
        'countryCode: $countryCode, '
        'regionCode: $regionCode, '
        'e164: $e164, '
        'national: $national, '
        'type: $type, '
        'international: $international, '
        'nationalNumber: $nationalNumber '
        '}';
  }
}
