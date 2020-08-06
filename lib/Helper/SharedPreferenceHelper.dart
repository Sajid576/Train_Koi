import 'package:trainkoi/Helper/Userprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{



  //this function used for storing user information in the local storage if user data is not saved in local storage.
  //this situation arises when user is not signed up yet or user uninstalled the app for some reasons.
  static setLocalData(String email,String phone,String username,String uid,int coin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('username', username);
    prefs.setString('uid', uid);
    prefs.setInt('coin', coin);
    prefs.setBool('session', true);


  }
  ///this function used for storing user information in the local storage
  static updateLocalData(String phone,String username) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('phone', phone);
    prefs1.setString('username', username);
    prefs1.setBool('session', true);
  }
  ///this function used for storing user coin data in the local storage
  static updateLocalCoinData(int coin) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setInt('coin', coin);
  }


  static setUserDP(img64) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('dp', img64);
  }



  ///this function used for fetching user data from local storage
  static  readfromlocalstorage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dp = prefs.getString('dp') ??'';
    String phone = prefs.getString('phone') ??'';
    String username=prefs.getString('username')??'';
    var session = prefs.getBool('session')?? false;
    String uid = prefs.getString('uid')??'';
    String email = prefs.getString('email')??'';
    int coin = prefs.getInt('coin')?? 0;


    Userprofiledetails userProfile = new Userprofiledetails(dp:dp,phone:phone,username: username,uid: uid,session: session,email: email,coin:coin);
    return userProfile;
  }

}