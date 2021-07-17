import 'package:flutter/material.dart';

import 'Constants/ScreenRoutes.dart';
import 'Screens/Home.dart';
import 'Screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}class _MyApp extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String initialRoute = ScreenNavigationConstant.HomeScreen;
    return MaterialApp(
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        ScreenNavigationConstant.loginScreen: (context) => LoginScreen(),
        ScreenNavigationConstant.HomeScreen: (context) => HomeScreen(),
      },
    );
  }
}
