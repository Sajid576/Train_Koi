
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView{

  static GoogleMapController googleMapController;
  static Map<MarkerId, Marker> markers ;
  static double trainLongitude=0;
  static double trainLatitutde=0;


  GoogleMapView();

  GoogleMapView.init()
  {
        markers = <MarkerId, Marker>{};
  }

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
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