final class DrawOnImageMethodCodec : NSObject, FlutterMethodCodec {
    required override init() {}
    
    static func sharedInstance() -> Self {
        Self()
    }
    
    func encode(_ methodCall: FlutterMethodCall) -> Data {
        return Data()
    }
    
    func decodeMethodCall(_ methodCall: Data) -> FlutterMethodCall {
        let reader = DrawOnImageReader(data: methodCall)
        let methodName = reader.readValue() as! String
        let data = reader.readValue()
        return FlutterMethodCall(methodName: methodName, arguments: data)
    }
    
    func encodeSuccessEnvelope(_ result: Any?) -> Data {
        guard let imagePath = result as? String else { return encodeErrorEnvelope(wrongEnvelopParameterType) }
        guard let pathData = imagePath.data(using: .utf8) else { return encodeErrorEnvelope(errorConvertingImageToData) }
        
        var buffer = Data()
        buffer.append(Data([succesOperationId]))
        buffer.append(Data([ui8String]))
        buffer.append(Data([UInt8(pathData.count)]))
        buffer.append(pathData)
        
        return buffer
    }
    
    func encodeErrorEnvelope(_ error: FlutterError) -> Data {
        let buffer = NSMutableData()
        let writer = FlutterStandardWriter(data: buffer)
        
        writer.writeValue(errorTypeId)
        writer.writeValue(error.code)
        writer.writeValue(error.message ?? "Default error message")
        writer.writeValue("No details")
        
        return buffer.copy() as! Data
    }
    
    func decodeEnvelope(_ envelope: Data) -> Any? {
        return nil
    }
}
