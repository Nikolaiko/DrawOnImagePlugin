#import "DrawOnImagePlugin.h"
#if __has_include(<draw_on_image_plugin/draw_on_image_plugin-Swift.h>)
#import <draw_on_image_plugin/draw_on_image_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "draw_on_image_plugin-Swift.h"
#endif

@implementation DrawOnImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDrawOnImagePlugin registerWithRegistrar:registrar];
}
@end
