import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';

import 'Home.dart';

class RoomPageAttendee extends StatefulWidget {
  String code;

  RoomPageAttendee({required this.code});

  @override
  _RoomPageAttendeeState createState() => _RoomPageAttendeeState();
}

class _RoomPageAttendeeState extends State<RoomPageAttendee> {
  FireBaseHelper fireBaseHelper = new FireBaseHelper();
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return StreamBuilder<DocumentSnapshot>(
      stream: fireBaseHelper.roomDetails(widget.code),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return _isDeleting
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    right: 16.0,
                  ),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                    strokeWidth: 3,
                  ),
                )
              : Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: Width * 0.4,
                              bottom: Height * 0.02,
                              top: Height * 0.02),
                          child: Text(
                            'Room Code: ' + snapshot.data!.get("code"),
                            style: TextStyle(
                                fontSize: Height * 0.05, color: Colors.black),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red,
                            ),
                            margin: EdgeInsets.only(
                                left: 8, right: 8, bottom: 12, top: 8),
                            padding: EdgeInsets.all(14),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Leave Room",
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
                            setState(() {
                              _isDeleting = true;
                            });
                            FireBaseHelper fireBaseHelper =
                                new FireBaseHelper();
                            fireBaseHelper.leaveRoom(widget.code);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
        );
      },
    );
  }
}
