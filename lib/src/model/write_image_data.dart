import 'package:draw_on_image_plugin/src/consts/default_values_consts.dart';
import 'package:flutter/services.dart';

class WriteImageData {  
  final String stringToWrite;
  final ByteData image;
  
  final int left;
  final int right;
  final int top;
  final int bottom;
  final int color;
  final int fontSize;

  const WriteImageData(
    this.stringToWrite, 
    this.image,
    {
      this.left = 0,
      this.right = 0,
      this.top = 0,
      this.bottom = 0,
      this.color = defaultColor,
      this.fontSize = defaultFontSize
    }
  ); 
}