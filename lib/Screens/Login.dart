import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grove_and_move/Providers/GoogleSigninProvider.dart';
import 'package:grove_and_move/Screens/Home.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return Container(
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return new SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        margin: EdgeInsets.only(
                            top: 0.01 * Height, bottom: 0.05 * Height),
                        child: CircleAvatar(
                          radius: Height * 0.2,
                          backgroundImage: AssetImage('assets/logo.jpg'),
                        ),
                      ),
                      new Text(
                        'App Name',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: Height * 0.10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 0.6 * Width,
                          height: Height * 0.07,
                          margin: EdgeInsets.only(top: Height * 0.02),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: new RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/google_logo.png',
                                  width: 25,
                                  height: 25,
                                ),
                                Container(
                                  color: Colors.black,
                                  height: 25.0,
                                  width: 1.0,
                                ),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            //textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            //highlightColor: Colors.red,
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.login();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
