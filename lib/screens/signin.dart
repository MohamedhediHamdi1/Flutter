import 'dart:convert';
import 'package:basic_utils/basic_utils.dart';


import 'package:cryptoo/main.dart';
import 'package:cryptoo/screens/signup.dart';
import 'package:cryptoo/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SignInScreen extends StatefulWidget {
  static const kBackgroundColor = Colors.white; static const kPrimaryColor =Colors.amber ;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  User user = User("","");
  String api = "192.168.1.105";





  Future save() async {
    String url = "http://"+api+":8011/users/login";
    String username = user.username;
    String password =user.password;
    Map<String, String> headers = {"Accept": "application/json"};
    var res = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({'username':'$username', 'password':'$password'}));
    print(res.statusCode);
    /*print(user.username);
    print(user.password);*/
    if (res.statusCode == 200) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      print("connected");
    }


  }
  var size,height,width;
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
                    color: SignInScreen.kPrimaryColor,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    width: width*0.8,
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
                    color: SignInScreen.kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width*0.8,
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

              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  child: Text("SingUp"),
              ),
              SizedBox(height: 5),
              Container(
                width: width*0.7,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen();*/
                    if (_formkey.currentState!.validate()) {
                      save();}
                  },
                  child: Text("SignIn"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}