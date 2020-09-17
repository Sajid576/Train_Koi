import 'package:trainkoi/Model/HttpApiService.dart';


class HttpController implements IHttpService{


  static requestSetUserData(email,username,phone,uid,coin) async
  {
        HttpApiService.requestSetUserData(email, username, phone, uid, coin);
  }

  static requestEditUserData(phone,username,uid)async
  {
        HttpApiService.requestEditUserData(phone, username, uid);
  }

  ///this request is for uploading image url to server
  static requestUploadImage(uid,dp) async
  {
        HttpApiService.requestUploadImage(uid, dp);
  }
  /// this method will be called from HomeScreen to fetch the User details and set those to the Profile Page when loaded.
  /// it will be called if user data is not available on local storage.
  static requestFetchUserData(uid) async
  {
        HttpApiService.requestFetchUserData(uid);
  }

}

class HttpTransactionController
{
  static requestAddCoinData(uid,requestedCoin) async
  {
        HttpTransactionApiService.requestAddCoinData(uid, requestedCoin);
  }

  static requestSpendCoinData(context,uid,trainName,startingStation,endingStation) async
  {
        HttpTransactionApiService.requestSpendCoinData(context, uid, trainName, startingStation, endingStation);
  }
}