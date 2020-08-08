
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapView{

  static String estimatedTime="";
  static String requiredDistance="";
  static var route=[];
  static String velocity="";
  static double trainLongitude=0;
  static double trainLatitutde=0;
  static double destLat=0;
  static double destLon=0;
  static String direction="";

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

        GoogleMapView.serviceNo=serviceNo;
        GoogleMapView.trainName=trainName;
        GoogleMapView.fromStation=startingStation;
        GoogleMapView.toStation=endingStation;


        markers = <MarkerId, Marker>{};
        // Map storing polylines created by connecting two points
        polylines = {};
  }

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  //add polyline to the Google Map widget
  static drawPolyline()
  {
    var polylineCoordinates=[];

    GoogleMapView.route.forEach((element) {
      var lat=double.parse( element.split(',')[0]);
      var lon=double.parse( element.split(',')[1]);

      polylineCoordinates.add(LatLng(lat,lon));

    });

    PolylineId id = PolylineId('poly');
    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    GoogleMapView.polylines[id]=polyline;

  }

  static setMarker()
  {
        // Train Location Marker
        Marker trainMarker = Marker(
          markerId: MarkerId("train"),
          position: LatLng(
            trainLatitutde,
            trainLongitude,
          ),
          infoWindow: InfoWindow(
            title: GoogleMapView.trainName,
            snippet: GoogleMapView.velocity,
          ),
          icon: BitmapDescriptor.defaultMarker,
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
                  title:GoogleMapView.fromStation   ,

                ),
                icon: BitmapDescriptor.defaultMarker,
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
                icon: BitmapDescriptor.defaultMarker,
              );
            }

            GoogleMapView.markers[MarkerId("train")]=trainMarker;
            GoogleMapView.markers[MarkerId('destination')]=destinationMarker;


          }




  }

  static setServerData(body)
  {
      if(GoogleMapView.serviceNo==1 || GoogleMapView.serviceNo==3)
        {
          GoogleMapView.estimatedTime=body['estimatedTime'];
          GoogleMapView.requiredDistance=body['requiredDistance'];
          GoogleMapView.route=body['route'];
          GoogleMapView.destLat= double.parse(body['destinationCordinate'].split(',')[0]) ;
          GoogleMapView.destLon= double.parse(body['destinationCordinate'].split(',')[1]) ;

          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=trainData['latitude'];
          GoogleMapView.trainLongitude=trainData['longitude'];


          drawPolyline();
          setMarker();

        }
      else
        {
          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=trainData['latitude'];
          GoogleMapView.trainLongitude=trainData['longitude'];

          setMarker();
        }

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