
import 'dart:async';

import 'package:draw_on_image_plugin/codecs/draw_image_data_method_codec.dart';
import 'package:draw_on_image_plugin/codecs/draw_image_data_message_codec.dart';
import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/services.dart';

class DrawOnImagePlugin {
  static MethodChannel _channel =
    MethodChannel('draw_on_image_plugin', DrawImageDataMethodCodec());

  Future<bool> writeTextOnImage(WriteImageData data) async {    
    return await _channel.invokeMethod("draw", data);
  }
}
