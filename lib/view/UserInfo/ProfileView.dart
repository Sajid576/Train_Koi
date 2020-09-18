
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:trainkoi/controller/HttpController.dart';
import 'package:trainkoi/view/PaymentGateway/CoinTransactionScreen.dart';
import 'dart:io' as Io;
import 'dart:convert';

import 'package:trainkoi/controller/LeftNavigationDrawyerController.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  //if an new image selected to change the dp then this _image variable will be initialized otherwise it will be null
  File _image;
  //after uploading the file to firebase storage, this variable have the download URL of that image that has to be stored
  //in cloud firestore
  String _uploadedFileURL="";


  String username="";
  String phoneNo="";
  String email="";
  String uid="";
  String userDP="";
  String coinAmount="";

  bool editEnabled=false;
  TextEditingController _usernameEditingController;
  TextEditingController _phoneNoEditingController;
  LeftNavDrawyer leftnavState;

  void initState(){
    super.initState();

    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);

    SharedPreferenceHelper.readfromlocalstorage().then((user) {

      setState(() {
        userDP=user.getDP();
        uid=user.getuid();
        phoneNo=user.getphone();
        username = user.getusername();
        email=user.getemail();
        coinAmount=user.getCoin().toString();

        _phoneNoEditingController=TextEditingController(text: phoneNo);
        _usernameEditingController=TextEditingController(text: username);

         print("UID: "+uid+",username: "+username+", phone: "+phoneNo+",Email: "+email+",coins: "+coinAmount);
      });

    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    leftnavState.controller.dispose();

  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
        _image = image;
        print('Image Path $_image');
    });
  }

  saveDpImage(imagePath,uid)
  {
      final bytes = Io.File(imagePath).readAsBytesSync();
      String img64 = base64Encode(bytes);
      SharedPreferenceHelper.setUserDP(img64);
      HttpController.requestUploadImage(uid,img64);

  }
  Widget profileLayout(BuildContext context)
  {

        return AnimatedPositioned(
            duration: LeftNavDrawyer.duration,
            top: 0,            //scale is done for top and bottom
            bottom: 0,
            left: leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width ,
            right:leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width,

            child: ScaleTransition(
                scale: LeftNavDrawyer.leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
                child: Material(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                elevation: 8,
                color: Colors.white,
                    child: Scaffold(
                backgroundColor: Colors.white,
                       appBar: AppBar(
                        leading: IconButton(
                             icon: Icon(Icons.menu,color: Colors.white,),
                               //onHorizontalDragEnd: (DragEndDetails details)=>_onHorizontalDrag(details),
                                onPressed: (){
                                setState(() {
                                    if(leftnavState.isCollapsed)
                                    {
                                          leftnavState.controller.forward();
                                    }
                                    else
                                    {
                                          leftnavState.controller.reverse();
                                    }
                                    LeftNavDrawyer.leftEnabled=!LeftNavDrawyer.leftEnabled;
                                    leftnavState.isCollapsed = !leftnavState.isCollapsed;
                                    //just reversing it to false
                                });
                        },),
                         title: Text('My Profile'),
                        centerTitle: true,
                        backgroundColor: Colors.black,
                ),
                     body: SingleChildScrollView(
                       child: Builder(
                         builder: (context) =>  Container(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: <Widget>[
                               SizedBox(
                                 height: 20.0,
                               ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Align(
                                   alignment: Alignment.center,
                                   child: CircleAvatar(
                                     radius: 100,
                                     backgroundColor: Colors.black45,
                                     child: ClipOval(
                                       child: new SizedBox(
                                         width: 180.0,
                                         height: 180.0,
                                         child: (_image!=null)?Image.file(
                                           _image,
                                           fit: BoxFit.fill,
                                         ):Image.asset('assets/person.png',fit: BoxFit.fill,),
                                       ),
                                     ),
                                   ),
                                 ),
                                 editEnabled? Padding(
                                   padding: EdgeInsets.only(top: 60.0),
                                   child: IconButton(
                                     icon: Icon(
                                       FontAwesomeIcons.camera,
                                       size: 30.0,
                                     ),
                                     onPressed: () {
                                       getImage();
                                     },
                                   ),
                                 ): Container(

                             ),
                           ],
                         ),
                             SizedBox(
                               height: 20.0,
                             ),

                             Align(
                               alignment: Alignment.center,
                               child: Container(
                                 child: Column(
                                   children: [
                                   Text('Username',
                                       style: TextStyle(
                                           color: Colors.blueGrey, fontSize: 18.0)),
                                   editEnabled? TextField(
                                     enabled: editEnabled,
                                     onChanged: (text) {

                                       _usernameEditingController.selection = TextSelection.fromPosition(TextPosition(offset: text.length));

                                     },
                                     controller: _usernameEditingController,
                                   ) : Text(username,
                                       style: TextStyle(
                                           color: Colors.black, fontSize: 18.0)),
                                   SizedBox(
                                     height: 20.0,
                                   ),
                                   Text('Email',
                                       style: TextStyle(
                                           color: Colors.blueGrey, fontSize: 18.0)),
                                   Text(email,
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 20.0,
                                           fontWeight: FontWeight.bold)),
                                   SizedBox(
                                     height: 20.0,
                                   ),
                                   Text('Mobile',
                                       style: TextStyle(
                                           color: Colors.blueGrey, fontSize: 18.0)),
                                   editEnabled ? TextField(
                                     enabled: editEnabled,
                                     onChanged: (text)
                                     {
                                     _phoneNoEditingController.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
                                   },
                                   controller: _phoneNoEditingController,
                                 ): Text(phoneNo,
                                     style: TextStyle(
                                         color: Colors.black, fontSize: 18.0)),

                               ],
                             ),
                           ),
                         ),

                             SizedBox(
                               height: 20.0,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: <Widget>[

                                 RaisedButton(
                                   color: editEnabled ? Colors.green : Colors.black,
                                   onPressed: () {
                                     if(editEnabled)
                                     {
                                           if(_image!=null)
                                           {
                                              saveDpImage(_image.path,uid);
                                           }
                                           if(username!=_usernameEditingController.text || phoneNo!=_phoneNoEditingController.text)
                                           {
                                                 username=_usernameEditingController.text;
                                                 phoneNo=_phoneNoEditingController.text;
                                                 HttpController.requestEditUserData(phoneNo, username, uid);
                                           }

                                     }
                                     setState(() {
                                       editEnabled=!editEnabled;
                                     });

                                   },

                                   elevation: 4.0,
                                   splashColor: Colors.white,
                                   child:editEnabled? Text('Save Info', style: TextStyle(color: Colors.white, fontSize: 16.0),) : Text('Edit Info', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                                 ),

                               ],
                             ),
                             SizedBox(
                               height: 50.0,
                             ),

                               Text("Account",
                                   style: TextStyle(
                                     decoration: TextDecoration.underline,
                                       color: Colors.black, fontSize: 40.0)),
                               SizedBox(
                                 height: 20.0,
                               ),
                               Text("Your coin amount is "+coinAmount,
                                   style: TextStyle(

                                       color: Colors.black, fontSize: 25.0)),
                               SizedBox(
                                 height: 20.0,
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: <Widget>[

                                   RaisedButton(
                                     color: Colors.black,
                                     onPressed: () {
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CoinPaymentScreen() ));


                                     },
                                     elevation: 4.0,
                                     splashColor: Colors.white,
                                     child: Text('Add Coins', style: TextStyle(color: Colors.white, fontSize: 16.0),) ,
                                   ),

                                 ],
                               ),

                               SizedBox(
                                 height: 50.0,
                               ),



                           ],



                     ),
                   ),
                 ),
               ),

            ),
            ),
          ),
        );

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Stack(
        children: <Widget>[

          leftnavState.leftNavLayout(context),
          profileLayout(context),
        ],
      ),
    );
  }
}