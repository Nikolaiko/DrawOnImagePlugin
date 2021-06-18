import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawOptionsDialog extends StatefulWidget {
  const DrawOptionsDialog({ Key? key }) : super(key: key);

  @override
  _DrawOptionsDialogState createState() => _DrawOptionsDialogState();
}

class _DrawOptionsDialogState extends State<DrawOptionsDialog> {
  final TextEditingController _drawTextController = new TextEditingController();
  final TextEditingController _fontSizeController = new TextEditingController();
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
              _buildColorPicker()    
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

  void _onColorChange(Color newColor) {
    _selectedColor = newColor;
  }
}