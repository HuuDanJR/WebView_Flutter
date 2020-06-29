import 'package:flutter/material.dart';
import 'package:ok_app_web/REST_text.dart';
import 'package:ok_app_web/webview_page1.dart';
import 'package:ok_app_web/webview_page2.dart';
import 'package:ok_app_web/webview_page3.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:MainPage(),
      home:WebViewPage3(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  List<Alligator> alligator = [
    /* Alligator(
        name: "Crunchy", description: "A fierce Alligator with many teeth."),
    Alligator(name: "Munchy", description: "Has a big belly, eats a lot."),
    Alligator(
        name: "Grunchy", description: "Scaly Alligator that looks menacing."), */
 ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.share,color:Colors.white), onPressed:() 
               {
                 _shareFB(context, alligator);
                               },
                               )
                             ],
                             bottom: TabBar(
                               isScrollable: true,
                               tabs: [
                                 Tab(
                                   // icon: Icon(Icons.directions_transit),
                                   text: "okcredit.vn"),
                                 Tab(
                                   // icon: Icon(Icons.directions_car), 
                                   text: "okblog.vn",),
                               ],
                             ),
                             title: Text('OK App',style:TextStyle(fontWeight:FontWeight.bold)),
                           ),
                           body: TabBarView(
                             children: [
                               // WebView1(),
                               WebviewPage1(),
                               WebviewPage2(),
                             ],
                           ),
                         /* floatingActionButtonLocation:
                           FloatingActionButtonLocation.centerDocked,
                           floatingActionButton: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               FloatingActionButton(
                                 onPressed: () {},
                                 tooltip: 'Go back',
                                 child: Icon(Icons.navigate_before),
                               ),
                               FloatingActionButton(
                                 onPressed: () {},
                                 tooltip: 'Share app',
                                 child: Icon(Icons.share),
                               )
                             ],
                           ),
                         ) */
                         ),
                       );
                   }
                 }
                 
                 void _shareFB(BuildContext context, alligator) {
                   final String title_app = 'Ok App Link';
   final String text = 'https://stackoverflow.com/questions/58297219/share-urlimagetext-with-twitter-facebook-instagram';
   final RenderBox box = context.findRenderObject();
}

class Alligator {
  String name;
  String description;
  Alligator({@required this.name, @required this.description});
}