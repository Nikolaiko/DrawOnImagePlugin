import 'dart:async';
import 'dart:io';

import 'package:draw_on_image_plugin/codecs/draw_image_data_method_codec.dart';
import 'package:draw_on_image_plugin/consts/name_constst.dart';
import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DrawOnImagePlugin {
  static MethodChannel _channel =
    MethodChannel(channelName, DrawImageDataMethodCodec());  

  const DrawOnImagePlugin();

  Future<String> writeTextOnImage(WriteImageData data) async {  
    String fileName = await _channel.invokeMethod(drawMethodName, data);
    Directory dir = await getApplicationDocumentsDirectory();    
    return "${dir.path}/$fileName";
  }
}
