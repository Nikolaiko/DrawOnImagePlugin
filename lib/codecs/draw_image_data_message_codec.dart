import 'dart:typed_data';

import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DrawImageDataMessageCodec extends StandardMessageCodec {
  static const int _writeImageData = 128;

  const DrawImageDataMessageCodec();

  @override
  void writeValue(WriteBuffer buffer, dynamic value)  {    
    if (value is WriteImageData) {      
      Uint8List imageBytesList = value.image.buffer.asUint8List(
        value.image.offsetInBytes, 
        value.image.lengthInBytes
      );

      buffer.putUint8(_writeImageData);
      super.writeValue(buffer, value.stringToWrite);
      super.writeValue(buffer, imageBytesList);
    } else {
      super.writeValue(buffer, value);
    }
  }
}