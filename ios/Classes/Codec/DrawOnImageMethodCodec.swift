final class DrawOnImageMethodCodec : NSObject, FlutterMethodCodec {
    private let basicCodec = FlutterStringCodec()
    
    required override init() {}
    
    static func sharedInstance() -> Self {
        Self()
    }
    
    func encode(_ methodCall: FlutterMethodCall) -> Data {
        return Data()
    }
    
    func decodeMethodCall(_ methodCall: Data) -> FlutterMethodCall {
        var length = methodCall.count
                
        print(length)
        let name = methodCall[2..<6]
        let decodedName = String(data: name, encoding: .utf8)
        
        print(decodedName)
        print(methodCall[6])
        
        return FlutterMethodCall()
    }
    
    func encodeSuccessEnvelope(_ result: Any?) -> Data {
        return Data()
    }
    
    func encodeErrorEnvelope(_ error: FlutterError) -> Data {
        return Data()
    }
    
    func decodeEnvelope(_ envelope: Data) -> Any? {
        return nil
    }
}
