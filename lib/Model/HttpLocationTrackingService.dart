import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trainkoi/Model/HttpApiService.dart';
import 'package:trainkoi/controller/GoogleMapView.dart';



abstract class IHttpLocationTrackingService
{
  static requestDrawRoute(serviceNo,trainName,startingStation,endingStation){}
}
class HttpLocationTrackingService implements IHttpLocationTrackingService
{
  //this method will be called when a user will query for 1st or 3rd service.This method will fetch the list of
  //coordinates from train to destination station or coordinates from train to Starting station so that blue color
  // route can be drawn on the Google Map.

  static requestDrawRoute(serviceNo,trainName,startingStation,endingStation)async
  {

    serviceNo=serviceNo.toString();
    //dynamic URL
    String url="routeBuilderApi/"+trainName+"/"+startingStation+"/"+endingStation+"/"+serviceNo;
    String mainUrl=IHttpService.serverUrl+url;

    http.Response res = await http.get(mainUrl);

    if (res.statusCode >= 200 && res.statusCode<=205)
    {
      //decode JSON to map
      Map<String, dynamic> body = jsonDecode(res.body);
      GoogleMapView.setServerResponse(body);


    } else {
      print("Data couldn't be fetched");
    }
  }
}