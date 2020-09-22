import 'dart:async';
import 'package:trainkoi/view/Authentication/LoginScreen.dart';
import 'package:trainkoi/view/Services/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  BuildContext context;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();

    setState(() {
      user = _user;
    });

  }
  @override
  void initState() {
    super.initState();



    getCurrentUser();

    Timer(Duration(
      milliseconds: 2000,
    ), () {
      Navigator.pop(context);
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(user.uid) )) ;
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen() )) ;
      }


    }
    );
  }


  @override
  Widget build(BuildContext context) {
    this.context=context;

    return new Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: new Image(
                image: new AssetImage('assets/app_logo.png')),
          ),
        ],
      ),
    );
  }


}