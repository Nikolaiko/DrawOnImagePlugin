import 'dart:ui' as ui;

import 'package:draw_on_image_plugin/model/write_image_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:draw_on_image_plugin/draw_on_image_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DrawOnImagePlugin _plugin = DrawOnImagePlugin();

  Future<void> _initPlatformState() async {
    ByteData imageBytes = await rootBundle.load("assets/images/test_image.png");
    _plugin.writeTextOnImage(
      WriteImageData("Some text", imageBytes)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: FutureBuilder(
          future: _initPlatformState(),
          builder: (futureContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildMainScreen();
            } else {
              return CircularProgressIndicator();
            }
          }
        )
      ),
    );
  }

  Widget _buildMainScreen() {
    return Center(
      child: Image.asset("assets/images/test_image.png"),
    );
  }

}
