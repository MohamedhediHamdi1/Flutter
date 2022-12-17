import 'admob/adReward.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future Connect() async {
  String api = ConstantVar.api;
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  String url = "http://" + api +
      ":8011/conecteduser/connect";
  try{
    var res = await http.get(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  } catch (e) {
  }
}