import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MyStreamController
{
  //it is initialized in GoogleMapView.init() constructor
  static StreamController<dynamic> googleMapScreenController;

  static StreamController<dynamic> ProfileViewStreamController;

}
class LoadingController
{
    static bool loading=false;
}