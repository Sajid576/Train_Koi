import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/view/Services/GoogleMapView.dart';


class HttpApiService{
    static const String serverUrl="http://localhost:3000/";

    //this method will be called while signing up
    static setUserData(email,username,phone,uid,coin) async
    {
         String url="authenticationApi/users";
         String mainUrl=serverUrl+url;
         var data = {
             'uid':uid,
             'email': email,
             'username':username,
             'phone':phone,
             'coins':coin
         };
         //encode Map to JSON
         var requestBody = json.encode(data);

         http.Response res = await http.post(mainUrl,
           headers:  {"Content-Type": "application/json"},
           body: requestBody,
         );

         if (res.statusCode >= 200 && res.statusCode<=205) {
             //decode JSON to map
             Map<String, dynamic> body = jsonDecode(res.body);
             var message=body['message'];
             AuxiliaryClass.showToast(message);

         } else {
             AuxiliaryClass.showToast("User failed to sign up");
         }

    }

    //this method will be called from Profile view to change user data
    static editUserData(phone,username,uid)async
    {
        String url="authenticationApi/users/edit";
        String mainUrl=serverUrl+url;
        var data = {
            'uid':uid,
            'username':username,
            'phone':phone,

        };
        //encode Map to JSON
        var requestBody = json.encode(data);

        http.Response res = await http.put(mainUrl,
            headers:  {"Content-Type": "application/json"},
            body: requestBody,
        );

        if (res.statusCode >= 200 && res.statusCode<=205) {
            //decode JSON to map
            Map<String, dynamic> body = jsonDecode(res.body);
            var message=body['message'];
            AuxiliaryClass.showToast(message);

        } else {
            AuxiliaryClass.showToast("data couldn't be edited");
        }
    }

    //this method will be called from HomeScreen to fetch the User details and set those to the Profile Page.
    //it will be called if user data is not available on local storage.
    static fetchUserData(uid) async
    {
        //dynamic URL
        String url="authenticationApi/users/read/"+uid;
        String mainUrl=serverUrl+url;

        http.Response res = await http.get(mainUrl);

        if (res.statusCode >= 200 && res.statusCode<=205) {
            //decode JSON to map
            Map<String, dynamic> body = jsonDecode(res.body);

            //saving the user data in local storage after fetching from server
            SharedPreferenceHelper.setLocalData(body['email'], body['phone'],body['username'],body['uid'],body['coins']);
            print(body['message']);

        } else {
            print("Data couldn't be fetched");
        }
    }
    //this method will be called when a user will query for 1st or 3rd service.This method will fetch the list of
    //coordinates from train to destination station or coordinates from train to Starting station so that blue color
    // route can be drawn on the Google Map.

    static requestDrawRoute(trainName,stationName,serviceNo)async
    {
        //dynamic URL
        String url="routeBuilderApi/"+trainName+"/"+stationName+"/"+serviceNo;
        String mainUrl=serverUrl+url;

        http.Response res = await http.get(mainUrl);

        if (res.statusCode >= 200 && res.statusCode<=205) {
            //decode JSON to map
            Map<String, dynamic> body = jsonDecode(res.body);
            GoogleMapView.setServerData(body,serviceNo);


        } else {
            print("Data couldn't be fetched");
        }
    }
}