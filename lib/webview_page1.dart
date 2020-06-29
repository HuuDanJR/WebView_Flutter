import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ok_app_web/navigation_control.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage1 extends StatefulWidget {
  @override
  _WebviewPage1State createState() => _WebviewPage1State();
}

class _WebviewPage1State extends State<WebviewPage1> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _controllerWebView;

  final request_N  = NavigationRequest;

  bool _isLoadingPage;

  var value;

  final _key = UniqueKey();

  var _url = 'https://okcredit.vn/';

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  @override
  void initState() {
    _isLoadingPage = true;
    super.initState();
  }

  Future<bool> _onBackPress(BuildContext context) async {
    print('click go back');
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Thoát App ngay?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('No')),
                FlatButton(
                    onPressed: () {
                      print('stop device');
                      /* Navigator.pop(context, false); */
                      exit(0);
                      // SystemNavigator.pop();
                    },
                    child: Text('Yes'))
              ],
            ));
    /* if (await _controllerWebView.canGoBack()) {
    print("onwill goback");
    _controllerWebView.goBack();
    return Future.value(true);
  } else {
    Scaffold.of(context).showSnackBar(
      const SnackBar(content: Text("No back history item")),
    );
    return Future.value(false);
  }  */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OK Credit')),
      floatingActionButton: NavigationControls(_controller.future),
      body: WillPopScope(
        // onWillPop: () => _onBackPress(context),
        onWillPop: () => _onBackPress(context),
        child: Stack(children: <Widget>[
          WebView(
            key: _key,
            initialUrl: _url,
            /* gestureRecognizers: Set()
    ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())), */
            gestureRecognizers: gestureRecognizers,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[
              _toasterJavascriptChannel(context),
            ].toSet(),
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              
              print('allowing navigation to $request $_isLoadingPage');
              return NavigationDecision.navigate;
            },
            onWebViewCreated: (webViewCreate) {
              _controller.complete(webViewCreate);
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          _isLoadingPage
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 0.5,
                  ),
                )
              : Container(width: 0, height: 0)
        ]),
      ),
    );
    
  }
  /* loadingProgress(){
  return FutureBuilder<NavigationRequest>(
    future:request_N,
    builder: (BuildContext context, AsyncSnapshot<NavigationRequest> snapshot){
    
  });
} */
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}

