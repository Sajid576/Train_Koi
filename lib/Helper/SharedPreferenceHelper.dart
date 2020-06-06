import 'package:trainkoi/Helper/Userprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{



  //write purpose
  static setLocalData(String email,String phone,String username,String uid,int coin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('username', username);
    prefs.setString('uid', uid);
    prefs.setInt('coin', coin);
    prefs.setBool('session', true);


  }
  //adding value which is update in editing option
  static updateLocalData(String phone,String username) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('phone', phone);
    prefs1.setString('username', username);
    prefs1.setBool('session', true);
  }
  static updateLocalCoinData(int coin) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setInt('coin', coin);
  }


  static setUserDP(img64) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('dp', img64);
  }



  //read user details
  static  readfromlocalstorage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dp = prefs.getString('dp') ??'';
    var phone = prefs.getString('phone') ??'';
    var username=prefs.getString('username')??'';
    var session = prefs.getBool('session')?? false;
    var uid = prefs.getString('uid')??'';
    var email = prefs.getString('email')??'';
    var coin = prefs.getString('coin')?? 0;


    Userprofiledetails userProfile = new Userprofiledetails(dp:dp,phone:phone,username: username,uid: uid,session: session,email: email,coin:coin);
    return userProfile;
  }

}