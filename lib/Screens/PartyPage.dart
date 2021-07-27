import 'package:flutter/material.dart';
import 'package:grove_and_move/Screens/RoomPageAttendee.dart';
import 'package:grove_and_move/Screens/RoomPageHost.dart';
import 'dart:math';
import 'package:grove_and_move/FirebaseHelper/firebaseHelper.dart';

class PartyPage extends StatefulWidget {
  @override
  _PartyPageState createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  final _formKey = GlobalKey<FormState>();
  var joinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  margin:
                      EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 8),
                  padding: EdgeInsets.all(14),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start a Room",
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
                  String code = getRandomString(4);
                  await fireBaseHelper.makeRoom(code);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomPageHost(
                        code: code,
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Join a Room",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Room Code:",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          // labelText: 'Type Item Name Here',
                        ),
                        validator: (v) {
                          if (v!.trim().isEmpty)
                            return 'Please enter something';
                          return null;
                        },
                        onChanged: (val) {
                          setState(
                            () {
                              joinCode = val;
                            },
                          );
                        },
                      ),
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green,
                        ),
                        margin: EdgeInsets.only(
                            left: 8, right: 8, bottom: 12, top: 8),
                        padding: EdgeInsets.all(14),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Join Room",
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
                        if (_formKey.currentState!.validate()) {
                          FireBaseHelper fireBaseHelper = new FireBaseHelper();
                          await fireBaseHelper.joinRoom(joinCode);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RoomPageAttendee(code: joinCode),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
