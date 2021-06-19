import Flutter
import UIKit

public class SwiftDrawOnImagePlugin: NSObject, FlutterPlugin {
    private let imageHelper = ImagePainter()
    private let fileHelper = FileHelper()
    
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
        switch call.method {
        case drawMethodName:
            if let drawData = call.arguments as? DrawOnImageData {
                if let newImage = imageHelper.drawOnImage(drawData: drawData) {
                    if let path = fileHelper.saveImageToDocuments(image: newImage) {
                        result(path)
                    } else {
                        result(errorSavingImage)
                    }
                } else {
                    result(errorConvertingImage)
                }
            } else {
                result(false)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }    
}
