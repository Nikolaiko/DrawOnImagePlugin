import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:draw_on_image_plugin/draw_on_image_plugin.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DrawOnImagePlugin _plugin = DrawOnImagePlugin();  

  Future<String> _initPlatformState() async {    
    ByteData imageBytes = await rootBundle.load("assets/images/test_image.png");
    print(Colors.red.value);
    String fileName = await _plugin.writeTextOnImage(
      WriteImageData(
        "Are you insane fucking serious\nrerereredfdffdfd\nfgdfdfdfdfdfdf\nHHHHASASASSADFDFDFFGF\nsdsddssddssddssdsd!!!!", 
        imageBytes,
        left: 200,
        right: 200,
        top: 200,
        bottom: 200,
        color: Colors.red.value,
        fontSize: 80
      ));
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/$fileName";
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: FutureBuilder<String>(
          future: _initPlatformState(),
          builder: (futureContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildMainScreen(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }
        )
      ),
    );
  }

  Widget _buildMainScreen(String bytes) {
    return Container(
      color: Colors.red,      
      child: Image.file(File(bytes))
    );
  }
}
