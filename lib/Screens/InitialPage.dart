import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grove_and_move/CommonWidgets/SongBox.dart';

Widget InitialPage() {
  return Container(
    
    color: Colors.black87,
    child: Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Popular Songs",style: TextStyle(color: Colors.white),
          ),
          // ListView.builder(
          //   itemCount: 3,
          //   itemBuilder: (context,index)=>SongBox(),)
        ],
      ),
    ),
  );
}
