import 'package:flutter/material.dart';
import 'package:grove_and_move/Screens/SearchScreen.dart';
typedef StringValue = String Function(String);
class ChooseSong extends StatefulWidget {
  @override
  _ChooseSongState createState() => _ChooseSongState();
  StringValue callback;
  ChooseSong({required this.callback});
}

class _ChooseSongState extends State<ChooseSong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchScreen(isSelectable: true, callback: (value) {
        widget.callback(value);
        Navigator.pop(context);
        return "";
      },),
    );
  }
}
