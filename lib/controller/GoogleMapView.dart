
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trainkoi/controller/MyController.dart';


class GoogleMapView{

  static String timeInfo="";
  static String estimatedTime="";
  static String requiredDistance="";
  static var route=[];
  static String velocity="";
  static double trainLongitude=0;
  static double trainLatitutde=0;
  static double destLat=0;
  static double destLon=0;
  static String station_junction1="";
  static String station_junction2="";

  static String trainName="";
  static String fromStation="";
  static String toStation="";
  static var serviceNo;


  static GoogleMapController googleMapController;
  static Map<MarkerId, Marker> markers ;
  static Map<PolylineId, Polyline> polylines;


  GoogleMapView();

  GoogleMapView.init(serviceNo,trainName,startingStation,endingStation)
  {
        print("Google map init called");

        MyStreamController.googleMapScreenController =new BehaviorSubject();

        GoogleMapView.markers = <MarkerId, Marker>{};
        GoogleMapView.polylines= <PolylineId, Polyline>{};
        /// init class variables
        GoogleMapView.timeInfo="";
        GoogleMapView.estimatedTime="";
        GoogleMapView.requiredDistance="";
        GoogleMapView.route=[];
        GoogleMapView.velocity="";
        //GoogleMapView.trainLongitude=0;
        //GoogleMapView.trainLatitutde=0;
        GoogleMapView.destLat=0;
        GoogleMapView.destLon=0;
        GoogleMapView.station_junction1="";
        GoogleMapView.station_junction2="";

        //init class variables with parameter values
        GoogleMapView.serviceNo=serviceNo;
        GoogleMapView.trainName=trainName;
        GoogleMapView.fromStation=startingStation;
        GoogleMapView.toStation=endingStation;

  }

  void _onMapCreated(GoogleMapController controller) {
        googleMapController = controller;
  }

  //add polyline to the Google Map widget
  static drawPolyline()
  {
    if(GoogleMapView.polylines!=null)
      {
        GoogleMapView.polylines.clear();
      }

    // Map storing polylines created by connecting two points

    var polylineCoordinates= new List<LatLng>();

    GoogleMapView.route.forEach((element) {
      var lat=double.parse( element.split(',')[0]);
      var lon=double.parse( element.split(',')[1]);

      polylineCoordinates.add(LatLng(lat,lon));

    });

    PolylineId id = PolylineId('poly');
    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    GoogleMapView.polylines[id]=polyline;

  }

  /// this method used to set train marker & destination station marker on google map
  static setMarker() async
  {
        //markers = <MarkerId, Marker>{};

        if(GoogleMapView.markers!=null)
          {
            GoogleMapView.markers.clear();
          }
        // Train Location Marker
        Marker trainMarker = Marker(
          markerId: MarkerId("train"),
          position: LatLng(
            trainLatitutde,
            trainLongitude,
          ),
          infoWindow: InfoWindow(
            title: GoogleMapView.trainName,
            snippet: "Velocity: "+GoogleMapView.velocity+" m/s",
          ),
          icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50,50)), 'assets/from.png'),
        );

        if(GoogleMapView.serviceNo!=2)
          {

            // Destination station Location Marker
            Marker destinationMarker;
            if(GoogleMapView.serviceNo==1)
            {
              destinationMarker = Marker(
                markerId: MarkerId('destination'),
                position: LatLng(
                  GoogleMapView.destLat,
                  GoogleMapView.destLon,
                ),
                infoWindow: InfoWindow(
                  title:GoogleMapView.fromStation ,

                ),
                icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50,50)), 'assets/to.png'),
              );

            }
            else if(GoogleMapView.serviceNo==3)
            {
              destinationMarker = Marker(
                markerId: MarkerId('destination'),
                position: LatLng(
                  GoogleMapView.destLat,
                  GoogleMapView.destLon,
                ),
                infoWindow: InfoWindow(
                  title:GoogleMapView.toStation ,

                ),
                icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50,50)), 'assets/to.png'),
              );
            }


            GoogleMapView.markers[MarkerId('destination')]=destinationMarker;

          }
        GoogleMapView.markers[MarkerId("train")]=trainMarker;
  }

  /// this method will be called repeatedly after getting response from the server. And then it will repeatedly
  /// update the Google map .
  static setServerResponse(body)
  {
      if(GoogleMapView.serviceNo==1 || GoogleMapView.serviceNo==3)
        {
          GoogleMapView.estimatedTime=       body['estimatedTime'].toString();
          GoogleMapView.timeInfo=            body['message'];
          GoogleMapView.requiredDistance=    body['requiredDistance'].toString();
          GoogleMapView.route=               body['route'];


          GoogleMapView.destLat= double.parse(body['destinationCordinate'].split(',')[0]) ;
          GoogleMapView.destLon= double.parse(body['destinationCordinate'].split(',')[1]) ;

          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=double.parse(trainData['latitude']);
          GoogleMapView.trainLongitude=double.parse(trainData['longitude']);

          print(body);
          drawPolyline();
          setMarker();

          if (GoogleMapView.googleMapController != null)
          {
            print("points:  "+GoogleMapView.trainLatitutde.toString()+","+GoogleMapView.trainLongitude.toString());
            GoogleMapView.googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

                target: LatLng(GoogleMapView.trainLatitutde,GoogleMapView.trainLongitude),
                zoom: 12.00)));

          }

        }
      else
        {

          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=double.parse( trainData['latitude']);
          GoogleMapView.trainLongitude= double.parse(trainData['longitude']);
          GoogleMapView.station_junction1  = body['nearestStation_junction'].split('-')[0];
          GoogleMapView.station_junction2  = body['nearestStation_junction'].split('-')[1];

          print(GoogleMapView.station_junction1+"-"+GoogleMapView.station_junction2);
          setMarker();

          if (GoogleMapView.googleMapController != null)
          {
            print("points:  "+GoogleMapView.trainLatitutde.toString()+","+GoogleMapView.trainLongitude.toString());
            GoogleMapView.googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(

                target: LatLng(GoogleMapView.trainLatitutde,GoogleMapView.trainLongitude),
                zoom: 12.00)));

          }
        }

      /// called for google map screen rendering
      MyStreamController.googleMapScreenController.add([GoogleMapView.trainLatitutde,GoogleMapView.trainLongitude]);

  }


  Widget googleMapLayout(serviceNo)
  {
    return GoogleMap(

      polylines: serviceNo == 1 || serviceNo ==3 ? Set<Polyline>.of(GoogleMapView.polylines.values) : null,
      //gestureRecognizer used for moving the view of google map by swiping
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
      ].toSet(),

      mapType: MapType.normal,

      initialCameraPosition: CameraPosition(
        target: LatLng(trainLatitutde,trainLongitude),
        zoom: 17,
      ),
      markers: Set<Marker>.of(markers.values),
      onMapCreated: _onMapCreated,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,

    );
  }
}