import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ok_app_web/link_api.dart';
import 'link_api.dart';
import 'package:ok_app_web/Link.dart';
class REST_Text extends StatelessWidget {
  
Future<List<Link>> _fetchLink() async {
  // String  url = 'http://localhost:8080/ok_app/get_link.php';
  String  url = 'https://huudan01234547079.000webhostapp.com/get_link.php';
  final response = await http.get(url);
  return linkFromJson(response.body);
  
}
  @override
  Widget build(BuildContext context) {
    String result = 'Result here';
    return Scaffold(
      appBar: AppBar(
        title:new Text('REST My SQL')
      ),
      body:ListView(
        children: <Widget>[
          RaisedButton(onPressed: (){}
          ,child: Text('get link'),
          ),
          RaisedButton(onPressed: (){}
          ,child: Text('post link'),
          ),
          Text(result),
          Container(height:400,width:double.infinity,
            child:FutureBuilder(
              future: _fetchLink(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Link link_item = snapshot.data[index];
                    return ListTile(
                      title:new Text('${link_item.name}'),
                      subtitle: Text('${link_item.link}'),
                    ) ;
                   },
                  );
                }
                else if(snapshot.hasError){
                  return new Text('Have an error while loading');
                }
                return Center(child: CircularProgressIndicator(strokeWidth: .6,));
              },
            ),
          )
        ],
      )
    );
  }
}