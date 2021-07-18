import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Login.dart';

import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black87,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print('Something went wrong');
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Container(
                child: Center(child: CircularProgressIndicator(),));
          },
        )
    );
  }
}

