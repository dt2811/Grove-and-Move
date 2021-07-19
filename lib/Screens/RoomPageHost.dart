import 'package:flutter/material.dart';

class RoomPageHost extends StatefulWidget {
  String code;

  RoomPageHost({required this.code});
  @override
  _RoomPageHostState createState() => _RoomPageHostState();
}

class _RoomPageHostState extends State<RoomPageHost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Code:"+widget.code)
          ],

        ),
      ),
    );
  }
}
