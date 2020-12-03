import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainkoi/Model/UserModel.dart';

class SharedPreferenceHelper{



  //this function used for storing user information in the local storage if user data is not saved in local storage.
  //this situation arises when user is not signed up yet or user uninstalled the app for some reasons.
  static setLocalData(UserModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userData.getemail());
    prefs.setString('phone', userData.getphone());
    prefs.setString('username', userData.getusername());
    prefs.setString('uid', userData.getuid());
    prefs.setInt('coin', userData.getCoin());
    prefs.setBool('session', true);


  }
  ///this function used for storing user information in the local storage
  static updateLocalData(UserModel userData) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('phone', userData.getphone());
    prefs1.setString('username', userData.getusername());
    prefs1.setBool('session', true);
  }
  static updateLocalUid(uid)async
  {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('uid', uid);
  }

  ///this function used for storing user coin data in the local storage
  static updateLocalCoinData(coin) async {
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


    UserModel userProfile = new UserModel(dp:dp,phone:phone,username: username,uid: uid,session: session,email: email,coin:coin);
    return userProfile;
  }

}