import 'package:http/http.dart' as http;
import 'Link.dart';

Future<List<Link>> _fetchLink() async {
  String  url = 'http://localhost:8080/ok_app/get_link.php';
  final response = await http.get(url);
  return linkFromJson(response.body);
  
}