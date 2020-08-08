import 'package:trainkoi/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:trainkoi/view/Services/ServiceScreen.dart';


void main()  {
 // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen(),
        //home:ServiceScreen(),
        debugShowCheckedModeBanner: false,


      );
  }
}








