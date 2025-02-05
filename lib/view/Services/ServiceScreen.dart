import 'package:flutter/material.dart';

import 'GoogleMapScreen.dart';

class ServiceScreen extends StatefulWidget {
  String trainName="";
  String startingStation="";
  String endingStation="";
  ServiceScreen(this.trainName,this.startingStation,this.endingStation);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {



  navigateToGoogleMapScreen(value)
  {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleMapScreen(value,widget.trainName,widget.startingStation,widget.endingStation)),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text("TrainKoi"),
            centerTitle: true,
            backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(

        child: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 150),
          child: ListView(
            shrinkWrap: true,
              children:  <Widget>[

                    Card(
                      color: Colors.red,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                        child: ListTile(
                          onTap:(){
                            navigateToGoogleMapScreen(1);
                          },
                        title: Text('শুরুর স্টেশনে ট্রেন আসতে কতক্ষন লাগবে?' ,style: TextStyle(
                              color: Colors.white,
                        ),),
                    ),

                   ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.red,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text('ট্রেন এখন কোথায়?',style: TextStyle(
                        color: Colors.white,
                      ),),

                      onTap:(){
                        navigateToGoogleMapScreen(2);
                      },
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.red,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ListTile(

                      title: Text('গন্তব্যে পৌছাতে কতক্ষন লাগবে? ',style: TextStyle(
                        color: Colors.white,
                      ),),

                      onTap:(){
                        navigateToGoogleMapScreen(3);
                      },
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
        ),
      ),
    );




  }
}
