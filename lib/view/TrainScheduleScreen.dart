
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrainScheduleScreen extends StatefulWidget {
  @override
  _TrainScheduleScreenState createState() => _TrainScheduleScreenState();
}

class _TrainScheduleScreenState extends State<TrainScheduleScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text("Train Schedule"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body:WebView(
          initialUrl: 'https://drive.google.com/file/d/1-WezcvBTvAAejccmvdUrTbeKxsIQ5QBp/view?usp=sharing',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),

    );


  }
}
