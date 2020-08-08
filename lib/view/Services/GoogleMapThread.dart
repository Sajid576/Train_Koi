import 'package:eventify/eventify.dart';
import 'dart:async';
import 'package:trainkoi/HttpClient/HttpApiService.dart';
import 'package:trainkoi/HttpClient/HttpLocationTrackingService.dart';

class GoogleMapThread
{
  static Listener subscriber;

  static var count=0;
  GoogleMapThread();

  static initThread(serviceNo,trainName, startingStation,endingStation)
  {

    count=0;
    ExtendedEmitter emitter = new ExtendedEmitter();
    subscriber=emitter.on("timer", null, (ev, context) {
        HttpLocationTrackingService.requestDrawRoute(serviceNo,trainName, startingStation,endingStation);
        count++;
        print(count.toString());

    });
    emitter.startListenForLocation();
  }


}

class ExtendedEmitter extends EventEmitter {
  void timerCallback(Timer timer) {
    emit("timer", this, timer);
  }
  void startListenForLocation() {
    Timer.periodic(Duration(seconds: 1), timerCallback);
  }
}


