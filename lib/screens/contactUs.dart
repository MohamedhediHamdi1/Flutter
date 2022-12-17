import 'package:cryptoo/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Contact_Us extends StatefulWidget  {
  const Contact_Us({Key? key}) : super(key: key);

  @override
  State<Contact_Us> createState() => _Contact_UsState();

}
final text1Controller = TextEditingController();
final text2Controller = TextEditingController();
final textController = TextEditingController();
String api = "hamdiyosri130gmail.ddns.net";
//String api = "192.168.1.105";

final storage = new FlutterSecureStorage();

String? token ="";
String? user_id ="";

String erreur="";
bool visibility=false;
int count=0;

class _Contact_UsState extends State<Contact_Us> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        title: 'submitted successfully',
        message:"",
        contentType: ContentType.success,
      ),
    );

    Future create_problem() async {
      String url = "http://"+api+":8011/problem";
      var res = await http.post(Uri.parse(url),
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "user_id":user_id,
            "email":textController.text,
            "title":text1Controller.text,
            "problem":text2Controller.text
          }));
      print(res.statusCode);
      if (res.statusCode == 201){
        print("connected");
        ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

      }
    }

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width:width,
            height: height,
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 50,
                  color: Theme.of(context).canvasColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return profile();
                              }));
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.white),
                      ),
                      Text(
                        "Contact Us",
                        style:  GoogleFonts.zenDots(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: width*0.15),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xff246EE9)),
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextFormField(
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      //controller: text7Controller,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 18),
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xff246EE9),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z\@\.]")),
                      ], // Only numbers
                    )
                ),
                //SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xff246EE9)),
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: TextFormField(
                    controller: text1Controller,
                    style: const TextStyle(color: Colors.white),
                    //controller: text7Controller,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                      //isDense: true,
                      hintText: "Title",
                      hintStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 18),
                      border: InputBorder.none,
                    ),
                    cursorColor: Color(0xff246EE9),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z\,\.]")),
                    ], // Only numbers
                  )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    width: width,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xff246EE9)),
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextFormField(
                      onChanged: (e){
                        count=e.length;
                        setState(() {});
                      },
                      controller: text2Controller,
                      maxLines: 10,
                      //maxLength: 300,
                      style: const TextStyle(color: Colors.white),
                      //controller: text7Controller,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                        //isDense: true,
                        hintText: "Describe your problem",
                        hintStyle: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 16),
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xff246EE9),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z\,\.]")),
                      ],
                    ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: visibility,
                          child:Text(
                            erreur,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                      ),
                      Text(
                        "$count/200",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(
                      30, 0, 30, 15),
                  decoration: BoxDecoration(
                    color: Color(0xff246EE9),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: TextButton(
                      onPressed: () async {
                        if(textController.text == null || textController.text.isEmpty || !textController.text.contains('@') || !textController.text.contains('.')){
                          erreur= 'Invalid Email';
                          visibility=true;
                        }
                        else if(text1Controller.text==""){
                          erreur="Empty title";
                          visibility=true;
                        }else if(text1Controller.text.length>30){
                          erreur="Title : max 30 character";
                          visibility=true;
                        }
                        else if(text2Controller.text.length<10){
                          erreur="Problem: min 20 character";
                          visibility=true;
                        }
                        else if(text2Controller.text.length>200){
                          erreur="Problem : max 200";
                          visibility=true;
                        }
                        else{
                          erreur="";
                          visibility=false;
                          token = await storage.read(key: "token");
                          user_id = await storage.read(key: "user_id");
                          await create_problem();
                          print("done");
                        }
                        setState(() {});
                        print(erreur);
                      },
                      child: Center(
                          child: Text(
                            'Send',
                            style: TextStyle(
                                color: Colors
                                    .white,
                                fontSize: 20),))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
