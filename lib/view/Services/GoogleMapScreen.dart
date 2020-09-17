import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'package:trainkoi/controller/HttpController.dart';
import 'file:///D:/Flutter_Projects/train_koi/lib/controller/GoogleMapThread.dart';
import 'file:///D:/Flutter_Projects/train_koi/lib/controller/GoogleMapView.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class GoogleMapScreen extends StatefulWidget {
  var serviceNo;

  String trainName="";
  String startingStation="";
  String endingStation="";
  GoogleMapScreen(this.serviceNo,this.trainName,this.startingStation,this.endingStation);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //instantiate the Google Map view object
    GoogleMapView.init(widget.serviceNo,widget.trainName,widget.startingStation,widget.endingStation);

    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 5), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Transaction processing ... ")
          ],
        ),
        ));
    //start the location data fetching thread.
    GoogleMapThread.initThread(_scaffoldKey,widget.serviceNo,widget.trainName,widget.startingStation,widget.endingStation);

  }


  @override
  void dispose() {
      super.dispose();
      //stop the location data fetching thread
      GoogleMapThread.subscriber.cancel();

  }

  Widget serviceOneAndThreeContainer()
  {
    //DraggableScrollableSheet needs a scrollable child widget like ListView or SingleChildScrollview.Then the scrollable widget must contain the
    //controller of the builder.
    return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.6,
        builder: (context,controller) {
          return Container(
            margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
            child: ListView(
              //this controller used for dragging the scrollable sheet
                controller: controller,
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('দূরত্ব', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text(GoogleMapView.requiredDistance, style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),

                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('সময়', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text(GoogleMapView.timeInfo, style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),


                ]
            ),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
          );

        },
    );
  }

  Widget serviceTwoContainer()
  {
    //DraggableScrollableSheet needs a scrollable child widget like ListView or SingleChildScrollview.Then the scrollable widget must contain the
    //controller of the builder.
    return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.6,
        builder: (context,controller) {
          return Container(
            margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
            child: ListView(
              //this controller used for dragging the scrollable sheet
                controller: controller,
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('ট্রেনের বর্তমান অবস্থান', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text('', style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),

                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('পূর্ববর্তী স্টেশন', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text('', style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),
                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('পরবর্তী স্টেশন', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text('', style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),


                ]
            ),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
     return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text("TrainKoi"),
    centerTitle: true,
    backgroundColor: Colors.black,
    ),
      body: Stack(
         children: <Widget>[
            GoogleMapView().googleMapLayout(widget.serviceNo),

           widget.serviceNo==1 || widget.serviceNo==3 ? serviceOneAndThreeContainer(): serviceTwoContainer(),



         ],
   ),

       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
       floatingActionButton: FloatingActionButton(
         onPressed: () {


           if (GoogleMapView.googleMapController != null)
           {

             GoogleMapView.googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                 bearing: 192.8334901395799,
                 target: LatLng(GoogleMapView.trainLatitutde,GoogleMapView.trainLongitude),
                 tilt: 30,
                 zoom: 18.00)));

           }

         },
         child: Icon(Icons.my_location, semanticLabel: 'Action'),
         backgroundColor: Colors.black87,
       ),

  );


  }


}
