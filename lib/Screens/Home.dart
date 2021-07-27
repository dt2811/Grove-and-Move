import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/Screens/LandingPage.dart';
import 'package:grove_and_move/Screens/MusicScreen.dart';
import 'package:grove_and_move/Screens/PartyPage.dart';
import 'package:grove_and_move/Screens/SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {

  final tabs = [
    LandingPage(),
    SearchScreen(isSelectable: false, callback: (value ) { return "";  },),
    PartyPage(),
    Container(
      color: Colors.white,
    )
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.green,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blueGrey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.blueGrey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.blur_on_outlined),
              label: "Join",
              backgroundColor: Colors.blueGrey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Profile",
              backgroundColor: Colors.blueGrey[900]),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
