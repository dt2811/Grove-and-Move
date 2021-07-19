import 'package:flutter/material.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';
import 'package:grove_and_move/Screens/Home.dart';

class RoomPageHost extends StatefulWidget {
  String code;
  RoomPageHost({required this.code});
  @override
  _RoomPageHostState createState() => _RoomPageHostState();
}

class _RoomPageHostState extends State<RoomPageHost> {

  @override
  Widget build(BuildContext context) {
    double Height =MediaQuery.of(context).size.height;
    double Width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: Width*0.4,bottom: Height*0.02,top:Height*0.02 ),
              child:Text('Room Code: '+widget.code  ,style: TextStyle(fontSize: Height*0.05,color: Colors.black),),
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 8),
                padding: EdgeInsets.all(14),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "End Room",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              onTap: () async {
                FireBaseHelper fireBaseHelper = new FireBaseHelper();
                await fireBaseHelper.deleteRoom(widget.code);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ],

        ),
      ),
    );
  }
}
