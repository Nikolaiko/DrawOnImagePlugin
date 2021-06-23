import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:draw_on_image_plugin/draw_on_image_plugin.dart';
import 'package:draw_on_image_plugin_example/draw_options_dialog.dart';
import 'package:draw_on_image_plugin_example/model/basic_draw_parameters.dart';
import 'package:draw_on_image_plugin_example/model/screen_dimensions.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DrawOnImage _plugin = DrawOnImage(); 
  String? _pathToNewFile; 

  Future<void> _sendPluginRequest(BasicDrawParameters params) async {    
    ByteData imageBytes = await rootBundle.load("assets/images/test_image.png");    
    String fileName = await _plugin.writeTextOnImage(
      WriteImageData(
        params.text, 
        imageBytes,
        left: params.left,
        right: params.right,
        top: params.top,
        bottom: params.bottom,
        color: params.color.value,
        fontSize: params.size
      ));

    setState(() {
      _pathToNewFile = fileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dimensions = ScreenDimensions(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Container(
              width: dimensions.width,
              height: dimensions.withoutSafeAreaHeight * 0.75,              
              child: _pathToNewFile == null
                ? _buildInitialScreen()
                : _buildMainScreen(),
            ),
            _buildButton()
          ]
        )
      ),
    );
  }

  Widget _buildButton() {    
    return ElevatedButton(
      onPressed: () async {
        _pathToNewFile = null;
        BasicDrawParameters params = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DrawOptionsDialog()
          )
        );
        _sendPluginRequest(params);
      }, 
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10.0),
        child: const Text("Draw"),
      )
    );
  }
  
  Widget _buildInitialScreen() {
    return Image.asset(
      "assets/images/test_image.png",
      fit: BoxFit.contain
    );
  }

  Widget _buildMainScreen() {
    return Image.file(
      File(_pathToNewFile ?? ""),
      fit: BoxFit.contain
    );
  }
}
