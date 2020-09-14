import 'package:trainkoi/Helper/AuxiliaryClass.dart';
import 'package:trainkoi/Helper/SharedPreferenceHelper.dart';
import 'package:trainkoi/HttpClient/HttpApiService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trainkoi/view/UserInfo/ProfileView.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class CoinPaymentScreen extends StatefulWidget {
  @override
  _CoinPaymentScreenState createState() => _CoinPaymentScreenState();
}

class _CoinPaymentScreenState extends State<CoinPaymentScreen> {

  int requiredAmount=0;
  double money=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()) )
          },
        ),
        title: Text("Transaction"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(

        child: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 50),
          child: ListView(
            shrinkWrap: true,
            children:  <Widget>[

              Card(
                color: Colors.black45,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(

                  title: Text('The amount of coins I want to add ',style: TextStyle(

                    color: Colors.white,
                  ),),

                ),


              ),
              SizedBox(
                height: 20,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton.icon(
                    color:  Colors.green ,
                  splashColor: Colors.white,
                  label: Text('Remove',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.remove, color:Colors.white,),
                    onPressed: () {
                      if(requiredAmount>0)
                        {
                          setState(() {
                            requiredAmount--;
                            money-=0.5;
                          });

                        }

                    },
                ),
                Text(requiredAmount.toString(),
                    style: TextStyle(
                        color: Colors.black, fontSize: 18.0)),

                RaisedButton.icon(
                  label: Text('Add',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.add, color:Colors.white,),
                  color:  Colors.green ,
                  elevation: 4.0,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      requiredAmount++;
                      money+=0.5;
                    });

                  },
                ),

              ]
            ),
              SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.black45,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ListTile(

                  title: Text('The amount of money(tk)    '+money.toString(),style: TextStyle(

                    color: Colors.white,
                  ),),

                ),


              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 0, right: 0, bottom: 50),
                child: Center(
                  child:  RaisedButton(
                    child: Text("Buy Coin",
                      style: TextStyle(color:Colors.white),
                    ),
                    color:  Colors.black,
                    onPressed:()  {
                      if(requiredAmount<2)
                        {
                             AuxiliaryClass.showToast("Please select at least 2 coins");
                             return;
                        }

                      _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(duration: new Duration(seconds: 2), content:
                          new Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("  Loading ... ")
                            ],
                          ),
                          ));
                      SharedPreferenceHelper.readfromlocalstorage().then((user) {
                        var uid=user.getuid();
                        HttpTransactionApiService.requestAddCoinData(uid, requiredAmount);

                      });

                    },

                    splashColor: Colors.grey,
                  ),
                ),
              )



            ],
          ),


        ),
      ),
    );
  }
}
