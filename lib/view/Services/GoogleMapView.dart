
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
  static String direction="";


  static GoogleMapController googleMapController;
  static Map<MarkerId, Marker> markers ;



  GoogleMapView();

  GoogleMapView.init()
  {
        markers = <MarkerId, Marker>{};
  }

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  static setServerData(body,serviceNo)
  {
      if(serviceNo==1 || serviceNo==3)
        {
          GoogleMapView.estimatedTime=body['estimatedTime'];
          GoogleMapView.requiredDistance=body['requiredDistance'];
          GoogleMapView.route=body['route'];

          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=trainData['latitude'];
          GoogleMapView.trainLongitude=trainData['longitude'];


        }
      else
        {
          var trainData=body['traindata'];
          GoogleMapView.velocity=trainData['velocity'];
          GoogleMapView.trainLatitutde=trainData['latitude'];
          GoogleMapView.trainLongitude=trainData['longitude'];
        }

  }


  Widget googleMapLayout()
  {
    return GoogleMap(

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