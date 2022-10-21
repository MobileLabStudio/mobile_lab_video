#import "MobileLabVideoPlugin.h"
#if __has_include(<mobile_lab_video/mobile_lab_video-Swift.h>)
#import <mobile_lab_video/mobile_lab_video-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mobile_lab_video-Swift.h"
#endif

@implementation MobileLabVideoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMobileLabVideoPlugin registerWithRegistrar:registrar];
}
@end
