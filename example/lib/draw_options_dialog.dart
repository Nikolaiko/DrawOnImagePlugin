import 'package:flutter/material.dart';

class DrawOptionsDialog extends StatefulWidget {
  const DrawOptionsDialog({ Key? key }) : super(key: key);

  @override
  _DrawOptionsDialogState createState() => _DrawOptionsDialogState();
}

class _DrawOptionsDialogState extends State<DrawOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: const <Widget>[
          Text('This is a demo alert dialog.'),
          Text('Would you like to approve of this message?'),
        ]
      )
    );
  }
}