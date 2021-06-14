import 'dart:typed_data';

import 'package:draw_on_image_plugin/consts/type_consts.dart';
import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DrawImageDataMessageCodec extends StandardMessageCodec {
  
  const DrawImageDataMessageCodec();

  @override
  void writeValue(WriteBuffer buffer, dynamic value)  {    
    if (value is WriteImageData) {      
      Uint8List imageBytesList = value.image.buffer.asUint8List(
        value.image.offsetInBytes, 
        value.image.lengthInBytes
      );

      buffer.putUint8(drawImageDataId);
      super.writeValue(buffer, value.stringToWrite);
      super.writeValue(buffer, value.left);
      super.writeValue(buffer, value.right);
      super.writeValue(buffer, value.top);
      super.writeValue(buffer, value.bottom);
      super.writeValue(buffer, value.color);
      super.writeValue(buffer, value.fontSize);
      super.writeValue(buffer, imageBytesList);
    } else {
      super.writeValue(buffer, value);
    }
  }
}