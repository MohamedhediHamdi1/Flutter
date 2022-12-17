import 'dart:convert';

import 'package:cryptoo/main.dart';
import 'package:cryptoo/screens/contactUs.dart';
import 'package:cryptoo/screens/signin.dart';
import 'package:cryptoo/screens/staticscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import '../admob/adReward.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  @override
  State<profile> createState() => _profileState();
}
String api =  ConstantVar.api;
//String api = "192.168.1.105";
Future Getcontact() async {
  String url = "http://" + api +
      ":8011/users/$user_id";
  try{
    var res = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      username = jsonData["username"];
    }
  } catch (e) {
    print("Getcontact problem");
    };
  }
String wallet ="100";
Future Getcontact1() async {
  String url = "http://" + api +
      ":8011/contacts/$contact_id";
  try{
    var res = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      print(jsonData["wallet"]);
      wallet = jsonData["wallet"].toString();
    }

  } catch (e) {
    print(contact_id);
    print("Getcontact erreur");
  }
}
double pnl7=0;
Future Getcontact2() async {
  String url = "http://" + api +
      ":8011/pnll/"+user_id!;
  var res = await http.get(Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (res.statusCode == 200) {
    var jsonData = json.decode(res.body);
    pnl7= jsonData["day7"];
  }
}


  String? token ;
  String? contact_id ;
  String? user_id ;
  String username = "user";
  String btcUsdtPrice ="20000";


Future local_storage() async{
 token = await storage.read(key: "token",);
 contact_id = await storage.read(key: "contact_id",);
 user_id = await storage.read(key: "user_id");
}
double deuxchiffre(double x) {
  String y = x.toString();
  int i = y.indexOf(".");
  try{
    y=y.substring(0,i+8);}
  catch(e){
    y=y;
  }
  return double.parse(y);
}


class _profileState extends State<profile> {
  streamListener(String pair) {
    var channel = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/' + pair + 'usdt@aggTrade');
    channel.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });

      // print(getData['p']);
    },
    );
    channel.sink.close();
  }
  final storage = new FlutterSecureStorage();
  bool e = false;
  var size, height, width;

  @override
  Widget build(BuildContext context)  {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Column(
                 children: [
                   Container(
                     width: width,
                     height: 40,
                     color: Theme.of(context).canvasColor,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         IconButton(
                           onPressed: (){
                             Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context) {
                                   return HomeScreen();
                                 }));
                           },
                           icon: Icon(Icons.arrow_back,color: Colors.white,),
                         ),
                          Text(
                           "Profile",
                           style:  GoogleFonts.zenDots(
                               color: Colors.white,
                               fontSize: 22,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         SizedBox(width: width*0.14),
                       ],
                     ),
                   ),
                   Container(
                     width: width,
                     height: 60,
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                     padding: EdgeInsets.only(left: 5),
                     decoration: BoxDecoration(
                         border: Border.all(width: 2,color: Color(0xff246EE9)),
                       color: Theme.of(context).canvasColor,
                       borderRadius: BorderRadius.all(Radius.circular(15))
                     ),
                     child: Row(
                       children: [
                         Icon(Icons.person_pin,size: 40,color: Colors.white,),
                         SizedBox(width: 10),
                         Text(
                             username,
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18,
                             fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     ),
                   ),
                   Container(
                     width: width,
                     height: 180,
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 2,color: Color(0xff246EE9)),
                       color: Theme.of(context).canvasColor,
                       borderRadius: BorderRadius.all(Radius.circular(15)),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "wallet",
                           style: TextStyle(
                             color: Theme.of(context).cardColor,
                             fontSize: 16,
                           ),
                         ),
                         SizedBox(height: 5),
                         Row(
                           children: [
                             Row(
                               children: [
                                 Text(
                                   wallet,
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 18,
                                   ),
                                 ),
                                 Text(
                                   " usdt",
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 15,
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                         SizedBox(height: 5),
                         Text(
                           "="+ (deuxchiffre(double.parse(wallet)/double.parse(btcUsdtPrice))).toString() +"BTC",
                           style: TextStyle(
                             color: Theme.of(context).cardColor,
                             fontSize: 16,
                           ),
                         ),
                         SizedBox(height: 15),
                         Text(
                           "Unrealized P&L",
                           style: TextStyle(
                             color: Theme.of(context).cardColor,
                             fontSize: 16,
                           ),
                         ),
                         SizedBox(height: 5),
                         Row(
                           children: [
                             Text(
                               "$pnl7",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 18,
                               ),
                             ),
                             Text(
                               " usdt",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 15,
                               ),
                             ),
                             SizedBox(width: 10),
                             InkWell(
                               onTap: (){
                                 Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (context) {
                                       return Static_screen();
                                     }));
                               },
                               child: Icon(Icons.arrow_forward,color: Color(0xff246EE9),size: 22,),
                             ),
                           ],
                         ),
                         SizedBox(height: 5),
                         Text(
                           "="+ (deuxchiffre(pnl7/double.parse(btcUsdtPrice))).toString() +"BTC",
                           style: TextStyle(
                             color: Theme.of(context).cardColor,
                             fontSize: 16,
                           ),
                         ),
                       ],
                     ),
                   ),
                   InkWell(
                     onTap: (){
                       Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) {
                             return Contact_Us();
                           }));
                     },
                     child: Container(
                       width: width,
                       height: 50,
                       padding: EdgeInsets.symmetric(horizontal: 15),
                       decoration: BoxDecoration(

                         color: Theme.of(context).canvasColor,
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Icon(Icons.contact_mail_outlined,color: Color(0xff246EE9),),
                               SizedBox(width: 15),
                               Text(
                                 "Contact Us",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 18,
                                 ),
                               ),
                             ],
                           ),
                           Icon(Icons.arrow_forward_outlined,color: Color(0xff246EE9),)
                         ],
                       ),
                     ),
                   ),
                   InkWell(
                     onTap: (){},
                     child: Container(
                       width: width,
                       height: 50,
                       padding: EdgeInsets.symmetric(horizontal: 15),
                       decoration: BoxDecoration(
                         color: Theme.of(context).canvasColor,
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Icon(Icons.feed,color: Color(0xff246EE9)),
                               SizedBox(width: 15),
                               Text(
                                 "User Feedback",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 18,
                                 ),
                               ),
                             ],
                           ),
                           Icon(Icons.arrow_forward_outlined,color: Color(0xff246EE9))
                         ],
                       ),
                     ),
                   ),
                   Container(
                     width: width,
                     height: 50,
                     padding: EdgeInsets.symmetric(horizontal: 15),
                     decoration: BoxDecoration(
                       color: Theme.of(context).canvasColor,
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Icon(Icons.notification_important_rounded,color:Color(0xff246EE9)),
                             SizedBox(width: 15),
                             Text(
                               "Notification",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 18,
                               ),
                             ),
                           ],
                         ),
                         Switch(value: e ,
                             onChanged: (x){
                               if(e==true){
                                 e=false;
                               }
                               else{
                                 e=true;
                               }
                               setState(() {});
                               print(e);
                             }
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
                InkWell(
                  onTap: ()async{
                    await storage.write(key: "token", value: "a");
                    //await storage.delete(key: "token");
                    await storage.write(key: "contact_id", value: "");
                    await storage.write(key: "user_id", value: "");
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                  child: Container(
                    width: width,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child:Center(
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState()  {
    super.initState();
    print("run2");
    test();
  }
  void test()async{
    await local_storage();
   await  Getcontact();
   await  Getcontact1();
    await Getcontact2();
    await streamListener("btc");
    setState(() {});
  }

}
