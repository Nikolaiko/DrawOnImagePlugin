import Flutter
import UIKit

public class SwiftDrawOnImagePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "draw_on_image_plugin",
            binaryMessenger: registrar.messenger(),
            codec: DrawOnImageMethodCodec()
        )
        let instance = SwiftDrawOnImagePlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }    
}
