import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cryptoo/main.dart';
import 'package:cryptoo/screens/signin.dart';
import 'package:cryptoo/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../admob/adReward.dart';

class SignUpScreen extends StatefulWidget {
  static const kBackgroundColor = Colors.white;
  static const kPrimaryColor = Colors.amber;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  final storage = new FlutterSecureStorage();
  String confirmpassword ="";
  final text1Controller = TextEditingController();
  final text2Controller = TextEditingController();
  final text3Controller = TextEditingController();
  String api = ConstantVar.api;
  //String api = "192.168.1.105";
  final String basicAuth = 'Basic ' + 'dXNlcjo4YmRiNjE5Yy01NGRhLTQ0YzQtYjYyOC05OTVlOTBhOWFjYWE=';
  String country = ":)";


  Future create_user() async {
    try {
     await http.get(Uri.parse("http://ip-api.com/json")).then((value) {
        country=json.decode(value.body)['country'].toString();
      });
    } catch (err) {
      //handleError
    }
    String url = "http://"+api+":8011/users";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'authorization': basicAuth,
        },
        body: json.encode({
          "username":text1Controller.text,
          "password": text2Controller.text,
          "admin":"false",
          "country":country,
          "nb_ads":"0",
          "options1":"0",
          "contact":{
            "order1": "false",
            "order2": "false",
            "order3": "false",
            "order4": "false",
            "position1": "false",
            "position2": "false",
            "position3": "false",
            "position4": "false",
            "wallet":100,
            "nombreoftrade": "0",
            "entryPrice1":"0",
            "entryPrice2":"0",
            "entryPrice3":"0",
            "entryPrice4":"0",
            "takeProfit1":"0",
            "takeProfit2":"0",
            "takeProfit3":"0",
            "takeProfit4":"0",
            "stopLoss1":"0",
            "stopLoss2":"0",
            "stopLoss3":"0",
            "stopLoss4":"0",
            "pair1":"btc",
            "pair2":"btc",
            "pair3":"btc",
            "pair4":"btc",
            "leverage1":10,
            "leverage2":10,
            "leverage3":10,
            "leverage4":10,
            "longorshort1":"true",
            "longorshort2":"true",
            "longorshort3":"true",
            "longorshort4":"true",
            "quantity1":0,
            "quantity2":0,
            "quantity3":0,
            "quantity4":0,
            "liqprice1":0,
            "liqprice2":0,
            "liqprice3":0,
            "liqprice4":0,
            "order1time":"ffff",
            "order2time":"ffff",
            "order3time":"ffff",
            "order4time":"ffff",
            "typeoftrade1":true,
            "typeoftrade2":true,
            "typeoftrade3":true,
            "typeoftrade4":true
          },
          "pnl":{
            "day1":0,
            "day2":0,
            "day3":0,
            "day4":0,
            "day5":0,
            "day6":0,
            "day7":0
          }
            }));
    print(res.statusCode);
    if (res.statusCode == 201){
      print("connected");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
    }
    else{
      erreur="User already exist";
      setState((){});
    }
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    validatePassword(text2Controller.text);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
                      child: Text(
                        "Sign In",
                        style:GoogleFonts.zenDots(
                            color: Color(0xff246EE9),
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:50),
                Text(
                  "Sign Up",
                  style: GoogleFonts.zenDots(
                      color: Colors.white,
                      fontSize: 26),
                ),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    width: width*0.92,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: text1Controller,
                      style: const TextStyle(color: Colors.white),
                      //controller: text7Controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        isDense: true,
                        prefixIcon: Icon(Icons.person,color: Colors.white,size: 25),
                        hintText: "Username",
                        hintStyle: GoogleFonts.roboto(
                            color: Theme.of(context).cardColor,
                            fontSize: 16),
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xff246EE9),
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                      ],
                    )
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    width: width*0.92,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: text2Controller,
                      style: const TextStyle(color: Colors.white),
                      //controller: text7Controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        isDense: true,
                        prefixIcon: Icon(Icons.lock_outlined,color: Colors.white,size: 22),
                        hintText: "Password",
                        hintStyle:  GoogleFonts.roboto(
                            color: Theme.of(context).cardColor,
                            fontSize: 16),
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xff246EE9),
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.deny(" ")],
                    )
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    width: width*0.92,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: text3Controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        isDense: true,
                        prefixIcon: Icon(Icons.lock_outlined,color: Colors.white,size: 22),
                        hintText: "Confirm Password",
                        hintStyle:  GoogleFonts.roboto(
                            color: Theme.of(context).cardColor,
                            fontSize: 16),
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xff246EE9),
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.deny(" ")],
                    )
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: validateur,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        "* "+erreur,
                        style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontSize: 14),
                      ),
                      IconButton(
                        onPressed: (){showDialogBox(context);},
                        icon: Icon(Icons.info,color: Colors.red,size: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: InkWell(
                    onTap: ()async{
                      erreur="";
                      validatePassword(text2Controller.text);
                      if(erreur!=""){
                        validateur=true;
                        setState(() {
                        });
                      }
                      else if(erreur==""){
                        validateur=false;
                        await create_user();
                      }
                    },
                    child: Container(
                      width: width*0.5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246EE9),
                        borderRadius:BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text("Sign Up",
                          style: GoogleFonts.zenDots(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool validateur =false;
  String erreur =" ";
  void validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if(text1Controller.text.length<6 || text1Controller.text.length>20){
      erreur='Username must be between 6 and 20 character';
    }
    else if (value.isEmpty) {
      erreur ='Please enter password';
    }
    else if (!regex.hasMatch(value)){
      erreur = 'Enter valid password';
    }
    else if(text2Controller.text!=text3Controller.text){
      erreur = 'Confirm password not matching';
    }
    else{
      validateur=false;
      erreur = "";
    }
    setState(() {});
  }

  Future<void> showDialogBox(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              buttonPadding:EdgeInsets.zero ,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                  width:width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "+ should contain at least one upper case.",
                        style:GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height:10),
                      Text(
                        "+ should contain at least one lower case.",
                        style:GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height:10),
                      Text(
                        "+ should contain at least one digit.",
                        style:GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height:10),
                      Text(
                        "+ Must be at least 8 characters in length.",
                        style:GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height:20),
                      Center(
                        child: Container(
                          width: width*0.3,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color(0xff246EE9),
                              borderRadius: BorderRadius.all(Radius.circular(5)
                              )
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Ok",
                              style:GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14,
                            ),
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          );
        }

    );
  }

}
