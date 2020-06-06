


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

        child: ListView(
            children:  <Widget>[

                  Card(
                      child: ListTile(
                        onTap: navigateToGoogleMapScreen(1),
                      title: Text('যাত্রা শুরুর স্টেশন থেকে ট্রেনের প্রয়োজনীয় সময় ও দূরত্ব'),
                  ),

                 ),
                Card(
                  child: ListTile(
                    title: Text('ট্রেন এখন কোথায়?'),

                    onTap: navigateToGoogleMapScreen(2),
                  ),

                ),
                Card(
                  child: ListTile(

                    title: Text('ট্রেন থেকে যাত্রা শেষ স্টেশনে পৌছাতে প্রয়োজনীয় সময় ও দূরত্ব'),
                    onTap: navigateToGoogleMapScreen(3),
                  ),

                ),
              ],
            ),
      ),
    );




  }
}
