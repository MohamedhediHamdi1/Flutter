import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cryptoo/main.dart';
import 'package:cryptoo/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../admob/adReward.dart';

class SignInScreen extends StatefulWidget {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  static const kBackgroundColor = Colors.white;
  static const kPrimaryColor = Colors.amber;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  int status=0;
  final storage = new FlutterSecureStorage();
  final _formkey = GlobalKey<FormState>();
  String api = ConstantVar.api;
  String user_id="";
  String contact_id="";
  String token="";
  Future Getcontact() async {
    String url = "http://" + api +
        ":8011/contacts/id/"+user_id;
    var res = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      contact_id = jsonData["contactId"];
    }
  }

  void check_internet1(BuildContext context) async {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(1),
            buttonPadding:EdgeInsets.zero ,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitDualRing(
                      color: Color(0xff246EE9),
                      size: 40,
                      lineWidth: 3,
                    ),
                    //IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                  ],
                );

              },
            ),
          );
        }
    );
  }





  Future save() async {
    String url = "http://" + api + ":8011/users/login";
    var res = await http.post(Uri.parse(url),
        headers: {"Content-type":"application/json"},
        body: jsonEncode({'username': text1Controller.text, 'password': text2Controller.text}));
    print(res.statusCode);
    if (res.statusCode == 200) {
      String header=res.headers.toString();
      int index = header.indexOf(", x-frame-options");
      token=header.substring(259,index);
      user_id=res.headers['useridd'].toString();
    }
    status=res.statusCode;
  }

  final text1Controller = TextEditingController();
  final text2Controller = TextEditingController();


  var size, height, width;
  @override
  Widget build(BuildContext context){
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
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
                        onPressed: ()async{
                           Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style:GoogleFonts.zenDots(
                              color: Color(0xff246EE9),
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:50),
                  Text(
                    "Login",
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
                      style: const TextStyle(color: Colors.white),
                      controller: text1Controller,
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
                        style: const TextStyle(color: Colors.white),
                        controller: text2Controller,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: InkWell(
                      onTap: ()async{
                        erreur="";
                        status=0;
                        validatePassword(text2Controller.text);
                        if(erreur!=""){
                          validateur=true;
                          setState(() {});
                        }
                        else if(erreur==""){
                          check_internet1(context);
                          await save();
                          if(status!=0&&status!=200){
                            validatePassword(text2Controller.text);
                            Navigator.pop(context);
                          }
                          else if(status==200) {
                            print("1111");
                            await Getcontact();
                            await storage.write(key: "token", value: token);
                            await storage.write(key: "contact_id", value: contact_id);
                            await storage.write(key: "user_id", value: user_id);
                            await storage.write(key: "leverage", value: "10");
                            await storage.write(key: "selectedmaxleverage", value: "125");
                            await storage.write(key: "pair", value: "btc");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return HomeScreen();}));
                            //await Navigator.push(context, await MaterialPageRoute(builder: (context) => HomeScreen(),));
                          }
                          //validateur=false;
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: width*0.5,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff246EE9),
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text("Log In",
                            style: GoogleFonts.zenDots(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 130),
                ],
              ),
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
    if(text1Controller.text.isEmpty==true){
      erreur ='Please enter Username';
    }
    else if(text1Controller.text.length<6 || text1Controller.text.length>20){
      erreur='Username must be between 6 and 20 character';
    }
    else if (value.isEmpty) {
      erreur ='Please enter password';
    }
    else if (!regex.hasMatch(value)){
      erreur = 'Enter valid password';
    }
    else if(status==403){
      erreur="The username or password is incorrect";
      validateur=true;
    }
    else{
      validateur=false;
      erreur = "";
    }
    setState(() {});
  }

  Future<void> check_token() async{

      print("signinscreen_check_token");
      String? token1 = await storage.read(key: "token");
      String url = "http://" + api +
          ":8011/actuator";
      try {
        print("1");
        var res = await http.get(Uri.parse(url),
          headers: {
            //'Content-Type': 'application/json',
            'Authorization': 'Bearer $token1',
          },
        );
        print(res.statusCode);

        if (res.statusCode == 200) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
          //FlutterNativeSplash.remove();
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        else {
          FlutterNativeSplash.remove();
        }
      } catch (e) {
        //print("firstscreen erreur");
        //await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
  }
  @override
  void initState() {
    check_token();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

