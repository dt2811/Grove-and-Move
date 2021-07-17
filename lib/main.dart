import 'package:flutter/material.dart';

import 'Constants/ScreenRoutes.dart';
import 'Screens/Home.dart';
import 'Screens/Login.dart';

import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
    return MaterialApp(
       home:LoginScreen(),
    );
  }
}
