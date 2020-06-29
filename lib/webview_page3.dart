import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ok_app_web/Link.dart';
import 'package:ok_app_web/Message.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
class WebViewPage3 extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<WebViewPage3> {
  Message message;
  InAppWebViewController webView;
  //link app to share
  final String url_share  ='https://stackoverflow.com/questions/58297219/share-urlimagetext-with-twitter-facebook-instagram';
  String url = "";
  String url_link ="";
  double progress = 0;
   
  Future<List<Link>> _fetchLink() async {
    // String  url = 'http://localhost:8080/ok_app/get_link.php';
    String url = 'https://huudan01234547079.000webhostapp.com/get_link.php';
    final response = await http.get(url);
    return linkFromJson(response.body);
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Back',
      style: optionStyle,
    ),
    Text(
      'Index 1: Next',
      style: optionStyle,
    ),
    Text(
      'Index 2: Refresh',
      style: optionStyle,
    ),
    Text(
      'Index 3: Share',
      style: optionStyle,
    ),
  ];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          print('index click 0');
          if (webView != null) {
            webView.goBack();
          }
          break;
        case 1:
          print('index click 1');
          if (webView != null) {
            webView.goForward();
          }
          break;
        case 2:
          print('index click 2');
          if (webView != null) {
            webView.reload();
          }
          break;
        case 3:
          print('index click 3');
          _shareFB(context, message);
          break;
        default:
      }
    });
  }

  void _shareFB(BuildContext context,Message subject){
   final String title_app = 'OK CREDIT LINK APP';
   final String text = url_link;
   final RenderBox box = context.findRenderObject();
   Share.share(
     text,
     subject: title_app,
     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
   );
  }
  //SHARE FUNCTION

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
          //hide item
          showSelectedLabels: false, // <-- HERE
          showUnselectedLabels: false, // <-- AND HERE
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.blue,
              ),
              title: Text('Back', style: TextStyle(color: Colors.blue)),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.navigate_next,
                color: Colors.blue,
              ),
              title: Text('Next'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              title: Text('Refresh'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.share,
                color: Colors.blue,
              ),
              title: Text('Share'),
            ),
          ],
        ),
        /* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  if (webView != null) {
                    webView.goBack();
                  }
                },
                child: Icon(Icons.navigate_before, color: Colors.blue),
              ),
              FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.refresh, color: Colors.blue),
                  onPressed: () {
                    if (webView != null) {
                      webView.reload();
                    }
                  }),
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  if (webView != null) {
                    webView.goForward();
                  }
                },
                child: Icon(Icons.navigate_next, color: Colors.blue),
              )
            ],
          ),
        ), */
        appBar: AppBar(
          title: const Text('OK CREDIT'),
          actions: <Widget>[
           /*  IconButton(icon: Icon(Icons.share), onPressed: (){
              _shareFB(context, message);
            }), */
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: new Text("Thoát app ngay?"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text('Yes'),
                            onPressed: () {
                              exit(0);
                            },
                          ),
                        ],
                      ));
                  // exit(0);
                })
          ],
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              /* Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
            ), */
              Container(
                  padding: EdgeInsets.all(0.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
                      Container(
              height: 0,
              width: double.infinity,
              child: FutureBuilder(
                future: _fetchLink(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new Text('Press button to start');
                    case ConnectionState.waiting:
                      return new Text('Awaiting result...');
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        url_link = snapshot.data[2].link;
                      print('url link name: $url_link');
                      /* return Column(
                        children: <Widget>[
                          new Text(
                              'Result: ${url_link = snapshot.data[2].link}'),
                          new Text('Share Link got: ${url_link}')
                          //still get  result link[2]
                        ],
                      ); */
                      return Container(height:0,width:0);
                  }
                },
              ),
            ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: InAppWebView(
                    initialUrl: "https://okcredit.vn/",
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
              /* ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (webView != null) {
                      webView.goBack();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (webView != null) {
                      webView.goForward();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    if (webView != null) {
                      webView.reload();
                    }
                  },
                ),
              ],
            ), */
            ])),
      ),
    );
  }
}
