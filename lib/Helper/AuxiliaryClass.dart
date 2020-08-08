import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/view/Services/ServiceScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';




class AuxiliaryClass{

  static Future<void> showMyDialog(context,message,coin,trainName,startingStation,endingStation) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must not tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wanna take service?'),
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {

                Navigator.of(context).pop();

                if(coin>0)
                  {
                      coin--;
                      //updating the coin amount in local database after decrementing the coin
                      SharedPreferenceHelper.updateLocalCoinData(coin);

                      //Snackbar
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('1 coin has been deducted from your account')));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ServiceScreen(trainName,startingStation,endingStation)),
                      );
                  }

              },
            ),
            FlatButton(
              child: Text('Decline'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  static showToast(String msg ){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  static Future<bool> checkInternetConnection() async
  {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    else return false;


  }


}