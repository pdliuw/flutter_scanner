#import "FlutterScannerPlugin.h"
#if __has_include(<flutter_scanner/flutter_scanner-Swift.h>)
#import <flutter_scanner/flutter_scanner-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_scanner-Swift.h"
#endif

@implementation FlutterScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterScannerPlugin registerWithRegistrar:registrar];
}
@end
