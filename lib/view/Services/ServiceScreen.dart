import 'package:trainkoi/view/Services/GoogleMapScreen.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {



  navigateToGoogleMapScreen(value)
  {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleMapScreen(value)),
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
                        title: Text('যাত্রা শুরুর স্টেশন থেকে ট্রেনের প্রয়োজনীয় সময় ও দূরত্ব' ,style: TextStyle(
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

                      title: Text('ট্রেন থেকে যাত্রা শেষ স্টেশনে পৌছাতে প্রয়োজনীয় সময় ও দূরত্ব',style: TextStyle(
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
