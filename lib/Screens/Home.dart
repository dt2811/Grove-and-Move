import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
 
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  final tabs = [
    Container(
      color: Colors.white,
    ),   
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    )
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Party Music"),
      //   backgroundColor: Colors.black,
      //   elevation: 10,
      // ),
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
            backgroundColor: Colors.blueGrey[900],
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.blueGrey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.blur_on_outlined),
              label: "Hosting",
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
