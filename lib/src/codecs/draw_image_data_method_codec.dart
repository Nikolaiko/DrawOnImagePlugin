import 'package:draw_on_image_plugin/src/codecs/draw_image_data_message_codec.dart';
import 'package:draw_on_image_plugin/src/consts/type_consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DrawImageDataMethodCodec extends MethodCodec {
  final _messageCodec = DrawImageDataMessageCodec();

  @override
  dynamic decodeEnvelope(ByteData envelope) {
    if (envelope.lengthInBytes == 0)
      throw const FormatException('Expected envelope, got nothing');

    final ReadBuffer buffer = ReadBuffer(envelope);        
    final resultId = buffer.getUint8();
    
    if (resultId == succesOperationId) {
      return _messageCodec.readValue(buffer);            
    }      

    final dynamic errorCode = _messageCodec.readValue(buffer);
    final dynamic errorMessage = _messageCodec.readValue(buffer);
    final dynamic errorDetails = _messageCodec.readValue(buffer);
    final String? errorStacktrace = (buffer.hasRemaining) ? _messageCodec.readValue(buffer) as String : null;
    if (errorCode is String && (errorMessage == null || errorMessage is String) && !buffer.hasRemaining)
      throw PlatformException(code: errorCode, message: errorMessage as String?, details: errorDetails, stacktrace: errorStacktrace);
    else
      throw const FormatException('Invalid envelope');
  }

  @override
  MethodCall decodeMethodCall(ByteData? methodCall) {    
    throw UnimplementedError();
  }

  @override
  ByteData encodeMethodCall(MethodCall methodCall) {
    WriteBuffer buffer = WriteBuffer();
    _messageCodec.writeValue(buffer, methodCall.method);
    _messageCodec.writeValue(buffer, methodCall.arguments);
    return buffer.done();
  }

  @override
  ByteData encodeErrorEnvelope({required String code, String? message, details}) {    
    throw UnimplementedError();
  }

  @override
  ByteData encodeSuccessEnvelope(result) {    
    throw UnimplementedError();
  }

}