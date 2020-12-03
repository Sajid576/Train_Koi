import 'package:trainkoi/Model/HttpApiService.dart';
import 'package:trainkoi/Model/UserModel.dart';

class HttpController implements IHttpService{


  static requestSetUserData(email,username,phone,uid,coin,dp) async
  {
    UserModel userProfile = new UserModel(dp:dp,phone:phone,username: username,uid: uid,session: true,email: email,coin:coin);

    HttpApiService.requestSetUserData(userProfile);
  }

  static requestEditUserData(phone,username,uid,dp,email)async
  {

    UserModel userProfile = new UserModel(dp:dp,phone:phone,username: username,uid: uid,email: email);

    HttpApiService.requestEditUserData(userProfile);
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

        UserModel userModel=new UserModel();
        userModel.setCoin(requestedCoin);
        userModel.setUid(uid);
        HttpTransactionApiService.requestAddCoinData(userModel);
  }

  static requestSpendCoinData(context,uid,trainName,startingStation,endingStation) async
  {
        HttpTransactionApiService.requestSpendCoinData(context, uid, trainName, startingStation, endingStation);
  }
}