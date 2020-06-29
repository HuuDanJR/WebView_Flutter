import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ok_app_web/navigation_control.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage2 extends StatefulWidget {
  @override
  _WebviewPage2State createState() => _WebviewPage2State();
}

class _WebviewPage2State extends State<WebviewPage2> {
  bool _isLoadingPage;

  WebViewController _controllerWebView;

   Completer<WebViewController> _controller = Completer<WebViewController>();
    final flutterWebViewPlugin = FlutterWebviewPlugin();

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
                      // Navigator.pop(context, false);
                      // SystemNavigator.pop();
                    },
                    child: Text('Yes'))
              ],
            ));
  }

  @override
  void initState() { 
    _isLoadingPage = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton:NavigationControls(_controller.future),
        body: Stack(
          children: <Widget>[
            WillPopScope(
              onWillPop: ()=>_onBackPress(context),
              child:WebviewScaffold(
                 withZoom: true,
        withLocalStorage: true,
        hidden: true,
         bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  
                ],
              ),
            ),
        appBar: new AppBar(
          elevation: 1.0,
          // centerTitle: true,
          title: const Text('OK Credit'),
          actions: <Widget>[
            IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    onPressed: () {
                      flutterWebViewPlugin.reload();
                    },
                  ),
            IconButton(icon: Icon(Icons.close), onPressed: (){
              print('exit app button');
              _onBackPress(context);
            }),

          ],
        ),
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: .5,)
          ),
        ),
                url: 'https://okcredit.vn/'),
                
            ),
            
          ],
        ),
      ),
    );
  }
}