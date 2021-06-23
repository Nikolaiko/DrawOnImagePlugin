import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:draw_on_image_plugin/draw_on_image_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

class DrawOptionsDialog extends StatefulWidget {
  const DrawOptionsDialog({ Key? key }) : super(key: key);

  @override
  _DrawOptionsDialogState createState() => _DrawOptionsDialogState();
}

class _DrawOptionsDialogState extends State<DrawOptionsDialog> {
  final TextEditingController _drawTextController = new TextEditingController();
  final TextEditingController _fontSizeController = new TextEditingController();
  final TextEditingController _leftController = new TextEditingController();
  final TextEditingController _rightController = new TextEditingController();
  final TextEditingController _topController = new TextEditingController();
  final TextEditingController _bottomController = new TextEditingController();
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextInputField(),
              _buildTextSizeField(),
              _buildPaddingsRow(),
              _buildColorPicker(),
              _buildButton()  
            ]
          )
        ),
      ),
    );
  }

  Widget _buildTextInputField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _drawTextController,
        keyboardType: TextInputType.multiline,
        maxLines: null,              
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Text to draw',
        )
      )
    );
  }

  Widget _buildTextSizeField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _fontSizeController,
        keyboardType: TextInputType.number,        
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Font Size',
        )
      )
    );
  }

  Widget _buildColorPicker() {
    return ColorPicker(
      pickerColor: _selectedColor,
      onColorChanged: _onColorChange,
      showLabel: true,
      pickerAreaHeightPercent: 0.8,
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: _doneButtonTap,
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10.0),
        child: const Text("Done"),
      )
    );
  }

  Widget _buildPaddingsRow() {
    return Row(      
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _leftController,
              keyboardType: TextInputType.number,        
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Left',
              )
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _rightController,
              keyboardType: TextInputType.number,        
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Right',
              )
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _topController,
              keyboardType: TextInputType.number,        
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Top',
              )
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _bottomController,
              keyboardType: TextInputType.number,        
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bottom',
              )
            ),
          ),
        )
      ]
    );
  }

  void _onColorChange(Color newColor) {
    _selectedColor = newColor;
  }

  void _doneButtonTap() {
    FocusScope.of(context).unfocus();    
    BasicDrawParameters? parameters = _buildDrawParameters(); 
    if (parameters == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error!"),
            content: Text("Error during creating parameters."),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                  onPressed: () => Navigator.of(context).pop()
              )
            ]
          );
        }
      );
    } else {
      Navigator.pop(context, parameters);
    }
  }

  BasicDrawParameters? _buildDrawParameters() {
    BasicDrawParameters? parameters; 

    try {
      int left = int.parse(_leftController.text);
      int right = int.parse(_rightController.text);
      int top = int.parse(_topController.text);
      int bottom = int.parse(_bottomController.text);
      int size = int.parse(_fontSizeController.text);

      parameters = BasicDrawParameters(
        _drawTextController.text, 
        _selectedColor, 
        size, 
        left, 
        right, 
        top, 
        bottom
      );
    } catch(error) {
      print("Error during building parameters : $error");
    } 
    return parameters;
  }
}

class ScreenDimensions {
  double width = 0;
  double fullHeight = 0;
  double withoutSafeAreaHeight = 0;

  ScreenDimensions(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    fullHeight = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    withoutSafeAreaHeight = fullHeight - padding.top - padding.bottom;
  }
}

class BasicDrawParameters {
  final Color color;
  final String text;
  final int size;
  final int left;
  final int right;
  final int top;
  final int bottom;

  const BasicDrawParameters(
    this.text,
    this.color,
    this.size,
    this.left,
    this.right,
    this.top,
    this.bottom,
  );
}