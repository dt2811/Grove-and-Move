import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';
import 'package:grove_and_move/Screens/Home.dart';
import 'package:grove_and_move/Screens/RoomPageAttendee.dart';

class RoomPageHost extends StatefulWidget {
  String code;

  RoomPageHost({required this.code});

  @override
  _RoomPageHostState createState() => _RoomPageHostState();
}

class _RoomPageHostState extends State<RoomPageHost> {
  FireBaseHelper fireBaseHelper = new FireBaseHelper();
  bool _isDeleting = false;
  bool _viewParticipants = false;

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

          List participants = [];
          if (!_isDeleting) participants = snapshot.data!.get('people');

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
                    child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: Width * 0.4,
                                  bottom: Height * 0.02,
                                  top: Height * 0.02),
                              child: Text(
                                'Room Code: ' + snapshot.data!.get("code"),
                                style: TextStyle(
                                    fontSize: Height * 0.04,
                                    color: Colors.white),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white54,
                                ),
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8, top: 8),
                                padding: EdgeInsets.all(14),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Participants (" +
                                          participants.length.toString() +
                                          ")",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    _viewParticipants
                                        ? Icon(Icons.arrow_drop_up,)
                                        : Icon(Icons.arrow_drop_down,)
                                  ],
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  _viewParticipants = !_viewParticipants;
                                });
                              },
                            ),
                            Visibility(
                              child: Container(
                                height: (participants.length * 70 > 300)
                                    ? 300
                                    : participants.length * 70,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                      future:
                                          getNameFromId(participants[index]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8, bottom: 5, top: 5),
                                          padding: EdgeInsets.all(14),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white10
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.hasData
                                                    ? snapshot.data
                                                    : "Loading",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              PopupMenuButton<int>(
                                                padding: EdgeInsets.only(bottom: 20),
                                                icon: Icon(Icons.more_horiz,color: Colors.white,),
                                                color: Colors.black,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem<int>(value: 0, child: Text("Make Host",style: TextStyle(color: Colors.white),)),

                                                  PopupMenuItem<int>(
                                                      value: 1, child: Text("Kick",style: TextStyle(color: Colors.white))),

                                                ],
                                                onSelected: (item) => SelectedItem(context, item, widget.code,participants[index]),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  itemCount: participants.length,

                                ),
                              ),
                              visible: _viewParticipants,
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
                                setState(() {
                                  _isDeleting = true;
                                });
                                FireBaseHelper fireBaseHelper =
                                    new FireBaseHelper();
                                fireBaseHelper.deleteRoom(widget.code);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
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

  Future<String> getNameFromId(String id) async {
    return await fireBaseHelper.firestore
        .collection('users')
        .doc(id)
        .get()
        .then((value) => value.get('name'));
  }
  void SelectedItem(BuildContext context, item,String code,String id) async {
    switch (item) {
      case 0:
        print("Host Clicked");
        await fireBaseHelper.changeHost(code, id);
        await fireBaseHelper.joinRoom(code);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RoomPageAttendee(code: code),
            ),
          );


        break;
      case 1:
        print("Kick Clicked");
        await fireBaseHelper.removeFromRoom(code, id);
        break;

    }
  }
}
