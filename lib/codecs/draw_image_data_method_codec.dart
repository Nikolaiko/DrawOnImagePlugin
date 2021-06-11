import 'package:draw_on_image_plugin/codecs/draw_image_data_message_codec.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DrawImageDataMethodCodec extends MethodCodec {
  final _messageCodec = DrawImageDataMessageCodec();

  @override
  decodeEnvelope(ByteData envelope) {
    // TODO: implement decodeEnvelope
    throw UnimplementedError();
  }

  @override
  MethodCall decodeMethodCall(ByteData methodCall) {
    // TODO: implement decodeMethodCall
    throw UnimplementedError();
  }

  @override
  ByteData encodeErrorEnvelope({String code, String message, details}) {
    // TODO: implement encodeErrorEnvelope
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
  ByteData encodeSuccessEnvelope(result) {
    // TODO: implement encodeSuccessEnvelope
    throw UnimplementedError();
  }

}