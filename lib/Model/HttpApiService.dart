import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/Model/UserModel.dart';
import 'package:trainkoi/controller/MyController.dart';
import 'package:trainkoi/view/Services/ServiceScreen.dart';
import 'package:trainkoi/controller/HttpController.dart';

abstract class IHttpService
{
    static const String serverUrl="https://trainkoi.herokuapp.com/";
    static requestSetUserData(email,username,phone,uid,coin)async {}
    static requestEditUserData(phone,username,uid)async{}
    static requestFetchUserData(uid) async{}

}

class HttpApiService implements IHttpService{


    //this method will be called while signing up
    static requestSetUserData(UserModel userData) async
    {
         String url="authenticationApi/users";
         String mainUrl=IHttpService.serverUrl+url;

         //encode Map to JSON
         var requestBody = json.encode(userData.getUserJsonData());

         http.Response res = await http.post(mainUrl,
           headers:  {"Content-Type": "application/json"},
           body: requestBody,
         );

         if (res.statusCode >= 200 && res.statusCode<=205) {
             //decode JSON to map
             Map<String, dynamic> body = jsonDecode(res.body);
             var message=body['message'];
             //user will given free 20 coins at the registration

             SharedPreferenceHelper.setLocalData(userData);

             AuxiliaryClass.showToast(userData.getemail()+" is successfully signed up");

         } else {
             AuxiliaryClass.showToast("User failed to sign up");
         }

    }


    static requestEditUserData(UserModel userProfile)async
    {
        String url="authenticationApi/users/edit";
        String mainUrl=IHttpService.serverUrl+url;

        //encode Map to JSON
        var requestBody = json.encode(userProfile.getUserJsonData());

        http.Response res = await http.put(mainUrl,
            headers:  {"Content-Type": "application/json"},
            body: requestBody,
        );

        if (res.statusCode >= 200 && res.statusCode<=205) {
            //decode JSON to map
            Map<String, dynamic> body = jsonDecode(res.body);
            var message=body['message'];

            SharedPreferenceHelper.updateLocalData(userProfile);
            AuxiliaryClass.showToast(message);
            MyStreamController.ProfileViewStreamController.add(0);

        } else {
            AuxiliaryClass.showToast("data couldn't be edited");
        }
    }


    
    static requestFetchUserData(uid) async
    {
        //dynamic URL
        String url="authenticationApi/users/read/"+uid;
        String mainUrl=IHttpService.serverUrl+url;

        print(mainUrl);
        http.Response res = await http.get(mainUrl);

        if (res.statusCode >= 200 && res.statusCode<=205) {
            //decode JSON to map
            Map<String, dynamic> body = jsonDecode(res.body);
            print(body);
            UserModel userModel=new UserModel.setUserJsonData(body);
            //saving the user data in local storage after fetching from server
            SharedPreferenceHelper.setLocalData(userModel);
            print(body['message']);

        } else {
            print("Data couldn't be fetched");
        }
    }

}

class HttpTransactionApiService
{
     static requestAddCoinData(UserModel userModel)async
     {
         String url="transactionApi/users/add";
         String mainUrl=IHttpService.serverUrl+url;

         //encode Map to JSON
         var requestBody = json.encode({
             'uid':userModel.getuid(),
             'requestedCoins':userModel.getCoin()
         });

         http.Response res = await http.put(mainUrl,
             headers:  {"Content-Type": "application/json"},
             body: requestBody,
         );

         if (res.statusCode >= 200 && res.statusCode<=205) {
             //decode JSON to map
             Map<String, dynamic> body = jsonDecode(res.body);
             var message=body['message'];
             var coin=( body['coins']);
             print(coin);
             SharedPreferenceHelper.updateLocalCoinData(coin);
             AuxiliaryClass.showToast(message);
         } else {
             AuxiliaryClass.showToast("Coin transaction failed to complete");
         }
     }

     static requestSpendCoinData(context,uid,trainName,startingStation,endingStation)async
     {
         String url="transactionApi/users/spend";
         String mainUrl=IHttpService.serverUrl+url;
         print("hehehe: "+uid);
         var data = {
             'uid':uid,

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
             var coin=body['coins'];

             SharedPreferenceHelper.updateLocalCoinData(coin);

             AuxiliaryClass.showToast(message);


             Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => ServiceScreen(trainName,startingStation,endingStation)),
             );

         } else {
             AuxiliaryClass.showToast("Coin transaction failed to complete");
         }
     }

}