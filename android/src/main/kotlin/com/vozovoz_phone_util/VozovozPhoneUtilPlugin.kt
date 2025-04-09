package com.vozovoz_phone_util


import com.google.i18n.phonenumbers.NumberParseException
import com.google.i18n.phonenumbers.PhoneNumberUtil
import com.google.i18n.phonenumbers.PhoneNumberUtil.PhoneNumberType
import com.google.i18n.phonenumbers.Phonenumber.PhoneNumber
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** VozovozPhoneUtilPlugin */
class VozovozPhoneUtilPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vozovoz_phone_util")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "parse" -> parse(call, result)
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            else -> result.notImplemented()
        }
    }

    private fun parse(call: MethodCall, result: Result) {
        val region = call.argument<String>("region")
        val string = call.argument<String>("string")
        if (string == null || string.isEmpty()) {
            result.error("InvalidParameters", "Invalid 'string' parameter.", null)
        } else {
            val util = PhoneNumberUtil.getInstance()
            val res: HashMap<String?, String?>? = parseStringAndRegion(string, region, util)
            if (res != null) {
                result.success(res)
            } else {
                result.error("InvalidNumber", "Number $string is invalid", null)
            }
        }
    }

    private fun parseStringAndRegion(
        string: String, region: String?,
        util: PhoneNumberUtil
    ): HashMap<String?, String?>? {
        return try {
            val phoneNumber: PhoneNumber = util.parse(string, region)
            if (!util.isValidNumber(phoneNumber)) {
                null
            } else object : HashMap<String?, String?>() {
                init {
                    val type: PhoneNumberType = util.getNumberType(phoneNumber)
                    val countryCode: Int = phoneNumber.countryCode
                    put("type", numberTypeToString(type))
                    put("e164", util.format(phoneNumber, PhoneNumberUtil.PhoneNumberFormat.E164))
                    put(
                        "international",
                        util.format(phoneNumber, PhoneNumberUtil.PhoneNumberFormat.INTERNATIONAL)
                    )
                    put(
                        "national",
                        util.format(phoneNumber, PhoneNumberUtil.PhoneNumberFormat.NATIONAL)
                    )
                    put("country_code", countryCode.toString())
                    put("region_code", util.getRegionCodeForCountryCode(countryCode).toString())
                    put(
                        "national_number",
                        java.lang.String.valueOf(phoneNumber.nationalNumber)
                    )
                }
            }
        } catch (e: NumberParseException) {
            null
        }
    }

    private fun numberTypeToString(type: PhoneNumberType): String {
        return when (type) {
            PhoneNumberType.FIXED_LINE -> "fixedLine"
            PhoneNumberType.MOBILE -> "mobile"
            PhoneNumberType.FIXED_LINE_OR_MOBILE -> "fixedOrMobile"
            PhoneNumberType.TOLL_FREE -> "tollFree"
            PhoneNumberType.PREMIUM_RATE -> "premiumRate"
            PhoneNumberType.SHARED_COST -> "sharedCost"
            PhoneNumberType.VOIP -> "voip"
            PhoneNumberType.PERSONAL_NUMBER -> "personalNumber"
            PhoneNumberType.PAGER -> "pager"
            PhoneNumberType.UAN -> "uan"
            PhoneNumberType.VOICEMAIL -> "voicemail"
            PhoneNumberType.UNKNOWN -> "unknown"
            else -> "notParsed"
        }
    }
}
