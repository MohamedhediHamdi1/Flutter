import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../admob/adReward.dart';
import '../admob/update_user.dart';

Future<void> showDialogBox(BuildContext context) async {

  late RewardedAd _rewardedAd;
  bool check_rewardedAd=false;
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  String? contact_id = await storage.read(key: "contact_id");
  String? user_id = await storage.read(key: "user_id");
  bool validator = false;
  final text1Controller = TextEditingController();
  double wallet = 100.0;
  Future Getcontact() async {
    String url = "http://" + api +
        ":8011/contacts/$contact_id";
    var res = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      print("connected");
      //print(res.body);
      var jsonData = json.decode(res.body);
      wallet = jsonData["wallet"];
    }
  }
  Future UpdateContactDouble(double x) async {
    String url = "http://" + api +
        ":8011/contacts/wallet/$contact_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"wallet": x}));
    if (res.statusCode == 202) {
    }
  }
  double deuxchiffre(double x) {
    String y = x.toString();
    int i = y.indexOf(".");
    try{
      y=y.substring(0,i+3);}
    catch(e){
      y=y;
    }
    return double.parse(y);
  }

  Future<InitializationStatus> _initgooglemobilead(){
    return MobileAds.instance.initialize();
  }
  void _loadRewardedAd(){
    //check_rewardedAd=false;
    RewardedAd.load(adUnitId: "ca-app-pub-6325257519832219/4202269239",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad){
              _rewardedAd=ad;
              ad.fullScreenContentCallback=FullScreenContentCallback(onAdDismissedFullScreenContent: (ad){
                check_rewardedAd=false;
                _loadRewardedAd();
              });
              check_rewardedAd=true;
            },
            onAdFailedToLoad: (erreur){print("fail to load RewardedAd");}
        )
    );
  }

  _initgooglemobilead();
  _loadRewardedAd();
  await Getcontact();

  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {

        var size = MediaQuery.of(context).size;
        var height = size.height;
        var width = size.width;
        return AlertDialog(
            buttonPadding:EdgeInsets.zero ,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
             Container(
               padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
               width:width,
               height: 222,
               decoration: BoxDecoration(
                 color: Theme.of(context).backgroundColor,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Text(
                         "ADD USDT",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 18,
                         ),
                       ),
                       SizedBox(width: width*0.18),
                       IconButton(
                           onPressed: (){Navigator.pop(context);},
                           icon: Icon(Icons.close,color: Theme.of(context).cardColor,),
                       ),
                     ],
                   ),
                   SizedBox(height: 10),
                   Row(
                     children: [
                       Row(
                         children: [
                           Text(
                             "Avbl",
                             style: TextStyle(
                               color: Theme.of(context).cardColor,
                               fontSize: 16,
                             ),
                           ),
                           Text(
                             deuxchiffre(wallet).toString(),
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 14,
                             ),
                           ),
                         ],
                       ),
                       Row(children: [
                         Text(
                           "Max:",
                           style: TextStyle(
                             color: Theme.of(context).cardColor,
                             fontSize: 14,
                           ),
                         ),
                         Text(
                           "100000 USDT",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(width: 5),
                       ],)
                     ],
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   ),
                   SizedBox(height: 10),
                   Row(
                     children: [
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 5),
                         width: width*0.64,
                         height: 40,
                         decoration: BoxDecoration(
                           color: Color(0xff2b3139),
                           borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                         ),
                         child: TextFormField(
                           onChanged: (value){
                             if(double.parse(value)+wallet > 100000){validator=true;}
                             else{validator=false;}
                             },
                           maxLines: 1,
                           style: const TextStyle(color: Colors.white),
                           controller: text1Controller,
                           decoration: InputDecoration(
                             hintText: "Add",
                             hintStyle: TextStyle(
                                 fontSize: 15,
                                 color: Colors.white),
                             border: InputBorder.none,
                           ),
                           cursorColor: Colors.amber,
                           keyboardType:TextInputType.numberWithOptions(decimal: true),
                           inputFormatters: <TextInputFormatter>[
                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                           ],
                         ),
                       ),
                       Container(
                         width: width*0.1,
                         height: 40,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                           color: Color(0xff2b3139),
                         ),
                         child: Center(
                           child: Text(
                             "USDT",
                             style: TextStyle(
                                 fontSize: 15,
                                 color: Colors.white
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: width*0.02,)
                     ],
                   ),
                   SizedBox(height:5),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Visibility(
                         visible: validator,
                         child: Text(
                           "You can add only "+(100000-wallet.toInt()).toString()+" USDT",
                           style: TextStyle(color: Colors.red,fontSize: 12),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 15),
                   Container(
                     width: width*0.45,
                     height: 45,
                     child: ElevatedButton(
                       style: ButtonStyle(backgroundColor: MaterialStateProperty
                           .all(Color(0xff246EE9))),
                       onPressed: () async {
                         try {
                           _rewardedAd.show(onUserEarnedReward: (
                               AdWithoutView ad, RewardItem item) async {
                             //_loadRewardedAd();
                             update_user();
                             if (validator == false) {
                               await Getcontact();
                               print(
                                   double.parse(text1Controller.text) + wallet);
                               await UpdateContactDouble(
                                   double.parse(text1Controller.text) + wallet);
                               Navigator.pop(context);
                             }
                           });
                         }catch(e){
                           if (validator == false) {
                             await Getcontact();
                             print(
                                 double.parse(text1Controller.text) + wallet);
                             await UpdateContactDouble(
                                 double.parse(text1Controller.text) + wallet);
                             Navigator.pop(context);
                           }
                           _loadRewardedAd();
                         }
                       },
                       child: Text(
                         "Confirm",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ),
            ]
        );
      }

  );

}

String api = ConstantVar.api;
//String api = "192.168.1.105";

