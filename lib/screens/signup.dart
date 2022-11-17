import 'dart:convert';

import 'package:cryptoo/main.dart';
import 'package:cryptoo/screens/signin.dart';
import 'package:cryptoo/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  static const kBackgroundColor = Colors.white;
  static const kPrimaryColor = Colors.amber;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  String confirmpassword ="";

  User user = User("", "");
  String api = "192.168.1.105";


  final String basicAuth = 'Basic ' + 'dXNlcjo4YmRiNjE5Yy01NGRhLTQ0YzQtYjYyOC05OTVlOTBhOWFjYWE=';

  Future save() async {
    String url = "http://"+api+":8011/users";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'authorization': basicAuth,
        },
        body: json.encode({
          "username": user.username,
          "password": user.password,
          "admin":"false",
          "contact":{
            "order1": "false",
            "order2": "false",
            "order3": "false",
            "position1": "false",
            "position2": "false",
            "position3": "false",
            "wallet":"100",
            "nombreoftrade": "0"
          }
            }));
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 201){

      print("connected");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
    }
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Color(0xff1f2630),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    Icons.alternate_email,
                    color: SignUpScreen.kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width * 0.8,
                    child: TextFormField(
                      controller: TextEditingController(text: user.username),
                      onChanged: (val) {
                        user.username = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is Empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Username",
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.lock,
                    color: SignUpScreen.kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width * 0.8,
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      onChanged: (val) {
                        user.password = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Password",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.lock,
                    color: SignUpScreen.kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width * 0.8,
                    child: TextFormField(
                      controller: TextEditingController(text: confirmpassword),
                      onChanged: (val) {
                        confirmpassword = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Confirm Password",
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                  child: Text("SignIn"),
              ),
              SizedBox(height: 10),
              Container(
                width: width * 0.7,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                   if(user.password == confirmpassword){
                     print("corect password");
                     if (_formkey.currentState!.validate()) {
                       save();
                     }
                     else{
                       print("incorect password");
                     }
                   }
                  },
                  child: Text("SignUp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
