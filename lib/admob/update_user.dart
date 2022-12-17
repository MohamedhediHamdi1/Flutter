import 'dart:convert';

import 'adReward.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> update_user()async {

  String? token="";
  String? user_id="";
  final storage = new FlutterSecureStorage();
  token = await storage.read(key: "token");
  user_id = await storage.read(key: "user_id");
  String api = ConstantVar.api;
    String url = "http://" + api +
        ":8011/users/"+user_id!;
    var res = await http.put(Uri.parse(url),
      body: json.encode({
        "s":"s"
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("update_user done : "+ res.statusCode.toString());
    if (res.statusCode == 202){
      print("update_user done");
    }
}