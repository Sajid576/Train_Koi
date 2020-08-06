import 'dart:io';
import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/view/Authentication/RegisterScreen.dart';
import 'package:trainkoi/view/Services/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;


class LoginScreen extends StatefulWidget {
  final String title = 'Login';
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign In')),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.centerLeft,
                end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
                colors: [Colors.green,Colors.black54,Colors.red], // whitish to gray
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Form(
                key: _formKey,
                child:
                Container(
                  //margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*.15,
                        width: MediaQuery.of(context).size.width*.25,
                        child: new CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          radius: 100.0,
                          child:Image.asset('assets/app_logo.png',width: 100,height: 100,),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                          //image: DecorationImage(image: this.logo)
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // margin:  EdgeInsets.only(left: 40.0, right: 40.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color:Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        //padding:  EdgeInsets.only(left: 0.0, right: 10.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.alternate_email,
                              color: Colors.white,),
                            hintText: 'Email',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            // border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter the email address';
                            }
                            return null;
                          },
                        ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //margin:  EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                                style: BorderStyle.solid),
                          ),
                        ),
                        //padding:  EdgeInsets.only(left: 0.0, right: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_open,
                              color: Colors.white,),
                            hintText: 'password',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            // border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a password with more than 5 digits';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        child:  FlatButton(

                          color:Colors.black.withOpacity(0.5) ,
                          //padding: EdgeInsets.all( 10,),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _signInWithEmailAndPassword();
                            }
                          },
                          child: Text('Login',style: TextStyle(color: Colors.white.withOpacity(0.5) )),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.center,
                        child: FlatButton(
                          //padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          //color: Colors.transparent,
                          onPressed: () => {},
                          child:  Text(
                            "Forgot your password?",
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.center,
                        child: FlatButton(
                          // padding: const EdgeInsets.all(10),
                          // color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Create One",
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ],


      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {

    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )).user;
      if (user != null) {
        setState(() {

          AuxiliaryClass.showToast(user.email+" successfully logged in");
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen( user.uid) ));

        });
      } else {
        AuxiliaryClass.showToast(user.email+" failed log in");
      }
    } on PlatformException catch (err) {
      AuxiliaryClass.showToast(err.message);
    } catch (err) {
      AuxiliaryClass.showToast(err.message);
    }
  }
}


