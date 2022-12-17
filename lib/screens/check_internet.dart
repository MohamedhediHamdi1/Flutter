
/*import 'dart:js';

import 'package:cryptoo/screens/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../admob/adReward.dart';
import '../main.dart';


  Future<void> check_token1() async{
    token = await storage.read(key: "token");
    String url = "http://"+api+
        ":8011/actuator";
    try{
      print("1");
    var res = await http.get(Uri.parse(url),
      headers: {
        //'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(res.statusCode);

      if (res.statusCode==200){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    };
    }catch(e){
      print("firstscreen erreur");
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }
}*/

