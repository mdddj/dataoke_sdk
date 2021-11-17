#import "DataokeSdkPlugin.h"
#if __has_include(<dataoke_sdk/dataoke_sdk-Swift.h>)
#import <dataoke_sdk/dataoke_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dataoke_sdk-Swift.h"
#endif

@implementation DataokeSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDataokeSdkPlugin registerWithRegistrar:registrar];
}
@end
