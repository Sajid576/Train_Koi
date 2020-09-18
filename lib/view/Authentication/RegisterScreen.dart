import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/controller/HttpController.dart';
import 'package:trainkoi/view/Authentication/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class RegisterScreen extends StatefulWidget {
  final String title = 'Sign Up';


  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String usernameValidator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: Colors.black,
      ),

      body: ListView(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.centerLeft,
                end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
                colors: [Colors.greenAccent,Colors.redAccent], // whitish to gray
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //margin:  EdgeInsets.only(left: 40.0, right: 40.0),
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
                      //margin:  EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color:Colors.white,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration:InputDecoration( hintText: 'password',
                          icon: Icon(Icons.lock_open,
                            color: Colors.white,),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          //border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter a password with more than 5 digits';
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
                      //margin:  EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color:Colors.white,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration( hintText: 'username',
                          icon: Icon(Icons.person,
                            color: Colors.white,),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          //border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty)
                          {
                            usernameValidator='Please enter your username';
                            return usernameValidator;
                          }
                          return usernameValidator;

                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //margin:  EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color:Colors.white,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration:  InputDecoration( hintText: 'mobile no',
                          icon: Icon(Icons.phone,
                            color: Colors.white,),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          // border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
                        ),
                        validator: (String value) {

                          if (value.trim().isEmpty) {
                            return 'Please enter your valid Mobile No.';
                          }
                          if(value.trim().length!=11)
                            {
                              return 'Please enter the 11 digit Mobile No.';
                            }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.black54,
                        onPressed: () async {

                          if (_formKey.currentState.validate()) {
                            _register();
                          }
                        },
                        child: Text('Register',style: TextStyle(color: Colors.white.withOpacity(0.5) )),
                      ),
                    ),

                  ],
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
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _userNameController.dispose();
    super.dispose();
  }



  // Example code for registration.
  void _register() async {

    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 2), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Signing-In... ")
          ],
        ),
        ));

    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      )).user;
      if (user != null) {

        HttpController.requestSetUserData(_emailController.text.trim(), _userNameController.text.trim(), _phoneController.text.trim(), user.uid,20);

        //Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen() ));

      } else {
        AuxiliaryClass.showToast(user.email+" failed signed up");
      }
    } on PlatformException catch (err) {
      AuxiliaryClass.showToast(err.message);
    } catch (err) {
      AuxiliaryClass.showToast(err.message);
    }
  }
}