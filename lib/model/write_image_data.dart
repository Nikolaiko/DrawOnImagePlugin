import 'package:flutter/services.dart';

class WriteImageData {  
  final String stringToWrite;
  final ByteData image;

  const WriteImageData(this.stringToWrite, this.image);
}