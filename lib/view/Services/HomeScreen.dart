import 'package:flutter/cupertino.dart';
import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/HttpClient/HttpApiService.dart';
import 'package:trainkoi/controller/LeftNavigationDrawyerController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:trainkoi/Helper/Train_Station_Lists.dart';
import 'dart:async';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  var authId;

  HomeScreen(this.authId);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  static var theme;

  final fromStationController=TextEditingController();
  final toStationController=TextEditingController();
  final trainNameController=TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LeftNavDrawyer leftnavState;


  checkUserData()
  {
    //if the user data is not saved in local storage for uninstalling app then it will fetch the user data from server
    SharedPreferenceHelper.readfromlocalstorage().then((user){
      if(user.getsession()==false)
      {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 2), content:
            new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("  Loading ... ")
              ],
            ),
            ));
        print("Data fetching");
        HttpApiService.fetchUserData(widget.authId);
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkUserData();

    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    leftnavState.controller.dispose();
    fromStationController.dispose();
    toStationController.dispose();
    trainNameController.dispose();
  }



  Widget HomeLayout(BuildContext context)
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
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              appBar: AppBar(
              leading:
              IconButton(
                icon: Icon(Icons.menu,
                  color: Colors.white,),
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
                  title: Text("TrainKoi"),
                  centerTitle: true,
                  backgroundColor: Colors.black,
              ),

            body: SingleChildScrollView(

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 150),
                child: Form(

                  key: _formKey,
                  child: Column(
                      children:<Widget>[


                        Container(
                          padding: EdgeInsets.only(left: 10,right:10),
                          //color: Colors.grey.withOpacity(0.5),
                          child: GestureDetector(
                            child: Card(
                              child: Theme(
                                data: theme.copyWith(primaryColor: Colors.deepPurple),
                                child: SimpleAutoCompleteTextField(

                                  onFocusChanged:(hasFocus)
                                  {

                                  },
                                  suggestions: Station.stationList,
                                  decoration: InputDecoration(

                                      enabledBorder: OutlineInputBorder(

                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: Colors.grey[200])),
                                      icon: Image.asset('assets/from.png'),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: Colors.grey[300])),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "যে স্টেশন হতে যাত্রা শুরু হবে"),
                                  controller: fromStationController,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10,right:10),
                          //color: Colors.grey.withOpacity(0.5),
                          child: GestureDetector(
                            child: Card(
                              child: Theme(
                                data: theme.copyWith(primaryColor: Colors.deepPurple),
                                child: SimpleAutoCompleteTextField(
                                  onFocusChanged:(hasFocus)
                                  {

                                  },
                                 suggestions: Station.stationList,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: Colors.grey[200])),
                                      icon: Image.asset('assets/to.png'),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: Colors.grey[300])),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "যে স্টেশনে যাত্রা শেষ হবে"),
                                  controller: toStationController,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 10,right:10),
                          //color: Colors.grey.withOpacity(0.5),
                          child: Card(
                            child: Theme(
                              data: theme.copyWith(primaryColor: Colors.deepPurple),
                              child: SimpleAutoCompleteTextField(
                                onFocusChanged:(hasFocus)
                                {

                                },
                                suggestions: TrainList.intercityTrainList,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: Colors.grey[200])),
                                    icon: Image.asset('assets/train.png',width: 60,height: 60,),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: Colors.grey[300])),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    hintText: "ট্রেনের নাম"),
                                controller: trainNameController,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 0, right: 0, bottom: 50),
                          child: Center(
                            child: RaisedButton(
                              child: Text("পরবর্তী"),
                              color:  Colors.black,
                              onPressed:() async{
                                if (fromStationController.text.isNotEmpty || toStationController.text.isNotEmpty || trainNameController.text.isNotEmpty)
                                {
                                  //fetching coin amount from local storage
                                  var user= await SharedPreferenceHelper.readfromlocalstorage();
                                  var coinAmount= user.getCoin();
                                  if(coinAmount>0)
                                  {
                                    var message="Your coin amount is "+coinAmount.toString()+".If you take the service 1 coin will be deducted from your account.Would you like to continue?";
                                    AuxiliaryClass.showMyDialog(_scaffoldKey,context,message,coinAmount,trainNameController.text,fromStationController.text,toStationController.text);

                                  }
                                  else
                                  {
                                    var message="Your coin amount is "+coinAmount.toString()+".If you want to take the service ,please recharge your coin first";
                                    AuxiliaryClass.showMyDialog(_scaffoldKey,context,message,coinAmount,trainNameController.text,fromStationController.text,toStationController.text);
                                  }


                                }
                                else
                                  {
                                    AuxiliaryClass.showToast("please fill up all the fields");
                                    return;
                                  }
                              },
                              textColor: Colors.yellow,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              splashColor: Colors.grey,
                            ),
                          ),
                        )

                      ]
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
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    theme = Theme.of(context);
    return Scaffold(
      body: Stack(
    children: <Widget>[

          leftnavState.leftNavLayout(context),
          HomeLayout(context),
    ],
    ),



    );
  }
}
