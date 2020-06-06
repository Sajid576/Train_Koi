import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/controller/LeftNavigationDrawyerController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    leftnavState.controller.dispose();

  }



  Widget HomeLayout(BuildContext context)
  {
    return SingleChildScrollView(

      child: Form(
        key: _formKey,
        child: Column(
            children:<Widget>[


              Container(
                padding: EdgeInsets.only(left: 10,right:10),
                //color: Colors.grey.withOpacity(0.5),
                child: Card(
                  child: Theme(
                    data: theme.copyWith(primaryColor: Colors.deepPurple),
                    child: TextFormField(

                      enableSuggestions: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the ending station';
                        }
                        return null;
                      },
                      enabled: true,
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
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right:10),
                //color: Colors.grey.withOpacity(0.5),
                child: Card(
                  child: Theme(
                    data: theme.copyWith(primaryColor: Colors.deepPurple),
                    child: TextFormField(
                      enableSuggestions: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the starting station';
                        }
                        return null;
                      },
                      enabled: true,
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
                      controller: fromStationController,
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
                    child: TextFormField(
                      enableSuggestions: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the train name';
                        }
                        return null;
                      },
                      enabled: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          icon: Image.asset('assets/train.png'),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "ট্রেনের নাম"),
                      controller: fromStationController,
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
                      if (_formKey.currentState.validate()) {
                        //fetching coin amount from local storage
                        var user= await SharedPreferenceHelper.readfromlocalstorage();
                        var coinAmount= user.getCoin();
                        if(coinAmount>0)
                        {
                          var message="Your coin amount is "+coinAmount.toString()+"If you take the service 1 coin will be deducted from your account.Would you like to continue?";
                          AuxiliaryClass.showMyDialog(context,message,coinAmount);
                        }
                        else
                        {
                          var message="Your coin amount is "+coinAmount.toString()+"If you want to take the service ,please recharge your coin first";
                          AuxiliaryClass.showMyDialog(context,message,coinAmount);
                        }


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
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text("TrainKoi"),
    centerTitle: true,
    backgroundColor: Colors.black,
    ),
      body: Stack(
    children: <Widget>[

          leftnavState.leftNavLayout(context),
          HomeLayout(context),
    ],
    ),



    );
  }
}
