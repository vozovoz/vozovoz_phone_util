#import "VozovozPhoneUtilPlugin.h"
#if __has_include(<vozovoz_phone_util/vozovoz_phone_util-Swift.h>)
#import <vozovoz_phone_util/vozovoz_phone_util-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vozovoz_phone_util-Swift.h"
#endif

@implementation VozovozPhoneUtilPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVozovozPhoneUtilPlugin registerWithRegistrar:registrar];
}
@end
