import Flutter
import PhoneNumberKit
import UIKit

public class VozovozPhoneUtilPlugin: NSObject, FlutterPlugin {
  private let kit = PhoneNumberUtility()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vozovoz_phone_util", binaryMessenger: registrar.messenger())
    let instance = VozovozPhoneUtilPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "parse": parse(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func parse(string: String, region: String?) -> [String: String]? {
    do {
      var phoneNumber: PhoneNumber
      if let region = region {
        phoneNumber = try kit.parse(string, withRegion: region)
      } else {
        phoneNumber = try kit.parse(string)
      }
      let regionCode = kit.getRegionCode(of: phoneNumber)
      return [
        "type": phoneNumber.type.rawValue,
        "e164": kit.format(phoneNumber, toType: .e164),
        "international": kit.format(phoneNumber, toType: .international, withPrefix: true),
        "national": kit.format(phoneNumber, toType: .national),
        "country_code": String(phoneNumber.countryCode),
        "region_code": String(regionCode ?? ""),
        "national_number": String(phoneNumber.nationalNumber),
      ]
    } catch {
      return nil
    }
  }

  private func parse(_ call: FlutterMethodCall, result: FlutterResult) {
    guard
      let arguments = call.arguments as? [String: Any],
      let string = arguments["string"] as? String
    else {
      result(
        FlutterError(
          code: "PhoneNumberKit: InvalidArgument",
          message: "PhoneNumberKit: phone number is missing.",
          details: nil))
      return
    }

    let region = arguments["region"] as? String

    if let res = parse(string: string, region: region) {
      result(res)
    } else {
      result(
        FlutterError(
          code: "PhoneNumberKit: InvalidNumber",
          message: "PhoneNumberKit: failed to parse phone '\(string)'.",
          details: nil))
    }
  }
}
