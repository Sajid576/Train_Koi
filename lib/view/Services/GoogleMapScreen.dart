import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trainkoi/Helper/GeoCoder.dart';
import 'package:trainkoi/controller/GoogleMapThread.dart';
import 'package:trainkoi/controller/GoogleMapView.dart';
import 'package:trainkoi/controller/MyController.dart';




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

  bool loading=false;
  String address='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading=true;
    //instantiate the Google Map view object
    GoogleMapView.init(widget.serviceNo,widget.trainName,widget.startingStation,widget.endingStation);
    //start the location data fetching thread.
    GoogleMapThread.initThread(widget.serviceNo,widget.trainName,widget.startingStation,widget.endingStation);

    /// value is a list =[trainLat,trainLon ]
    MyStreamController.googleMapScreenController.stream.listen((value) {
      print("Google Map Screen rendered");
        print("value list:  "+value.toString());
        if(value!=null)
          {
            loading=false;
          }
        if(widget.serviceNo==2)
        {

            GeoCoder.geoCoding(value[0], value[1]).then((address){
              setState(() {
                this.address=address;
              });

            });
        }
        else{
            setState(() {
            });
        }
      });



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
                      subtitle: Text(GoogleMapView.requiredDistance+" কি.মি", style: TextStyle(
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
                      subtitle: Text(address, style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),

                  ),

                  Card(
                    color: Colors.black.withOpacity(0.0),
                    child: ListTile(

                      title: Text('ট্রেন এখন '+GoogleMapView.station_junction1+' ও '+ GoogleMapView.station_junction2+' এর মাঝে অবস্থিত'
                        , style: TextStyle(
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

     return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text("TrainKoi"),
    centerTitle: true,
    backgroundColor: Colors.black,
    ),
      body: Stack(
         children: <Widget>[
            GoogleMapView().googleMapLayout(widget.serviceNo),

           loading==true ? Center(child: CircularProgressIndicator(),) :
           widget.serviceNo==1 || widget.serviceNo==3 ? serviceOneAndThreeContainer(): serviceTwoContainer(),


         ],
   ),

       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
       floatingActionButton: FloatingActionButton(
         onPressed: () {


           if (GoogleMapView.googleMapController != null)
           {

             GoogleMapView.googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(

                 target: LatLng(GoogleMapView.trainLatitutde,GoogleMapView.trainLongitude),

                 zoom: 18.00)));

           }

         },
         child: Icon(Icons.my_location, semanticLabel: 'Action'),
         backgroundColor: Colors.black87,
       ),

  );


  }


}
