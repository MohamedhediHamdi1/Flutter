import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../admob/adReward.dart';
import '../admob/update_user.dart';
import '../main.dart';

Future<void> closeDialogBox(BuildContext context,String quantity,String longorshort,String entryPrice,String leverage,String pair,String markprice1,String takeprofit,String stoploss,String position,String liqprice) async {
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  String? contact_id = await storage.read(key: "contact_id");
  String? user_id = await storage.read(key: "user_id");

  late RewardedAd _rewardedAd;
  bool check_rewardedAd=false;

  bool button1=false;
  bool button2=false;
  bool button3=false;
  bool button4=false;
  bool button5=false;
  String api = ConstantVar.api;
  //String api = "192.168.1.105";
  double quantity1 =0.0;
  bool longorshort1=true;
  String entryPrice1="0";
  double leverage1=0.0;
  String pair1="btc";
  String takeprofit1="0";
  String stoploss1="0";




  TypeOfColor(bool x) {
    if (x == true) {
      return Colors.blue;
    }
    else if (x == false) {
      return Theme.of(context).backgroundColor;
    }
  }

  Future UpdateContactBoolean(String parametre, bool bool) async {
    print("*********" + parametre +"**************");
    String url = "http://"+api+
        ":8011/contacts/wallet/$contact_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"$parametre": bool}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updated");
    }
  }

  Future UpdateContactString(String parametre, String string) async {
    String url = "http://" + api +
        ":8011/contacts/wallet/$contact_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({parametre: string}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updated");
    }
  }

  Future UpdateContactDouble(String parametre, double double) async {
    String url = "http://" + api +
        ":8011/contacts/wallet/$contact_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({parametre: double}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updated");
    }
  }
  Future UpdateContactDouble1(String parametre, double double) async {
    String url = "http://" + api +
        ":8011/pnll/$user_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({parametre: double}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updated");
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

  double unrealizedpnl(String entryprice, String markprice, bool longorshort, double leverage, bool position) {
      double x = double.parse(entryprice);
      double y = double.parse(markprice);
      double s = (((y - x) / x * leverage * 100));
      if (longorshort == true) {
        return s;
      }
      else {
        return -s;
      }

  }


  String calcul(double x){
    double pnl = unrealizedpnl(entryPrice1,markprice1,longorshort1,leverage1,true)/100*quantity1;
    double y = (quantity1*0.995*x)+(pnl*x);
    String z = deuxchiffre(y).toString();
    return z;
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
                check_rewardedAd=true;
              });
            },
            onAdFailedToLoad: (erreur){print("fail to load RewardedAd");}
        )
    );
  }
  _initgooglemobilead();
  _loadRewardedAd();
  double h = 0.0;



  String x = "0";
  bool validator = false;
  final text1Controller = TextEditingController();


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
      var jsonData = json.decode(res.body);
      quantity1 = jsonData[quantity];
      longorshort1 = jsonData[longorshort];
      entryPrice1 = jsonData[entryPrice];
      leverage1 = jsonData[leverage];
      pair1 = jsonData[pair];
      h = jsonData["wallet"];
    }
    print(quantity1);
    print(longorshort1);
    print(entryPrice1);
    print(leverage1);
    print(h);
  }
bool xx=true;
  if(xx==true)  {
    await Getcontact();
    xx=false;
  }
  await showDialog<void>(

      context: context,

      builder: (BuildContext context) {

        var size = MediaQuery.of(context).size;
        var height = size.height;
        var width = size.width;
        return AlertDialog(
          insetPadding: EdgeInsets.all(1),
            buttonPadding:EdgeInsets.zero ,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width:width ,
                  height: 320,
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
                            "Close Position",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: width*0.16),
                          IconButton(
                            onPressed: (){Navigator.pop(context);},
                            icon: Icon(Icons.close,color: Theme.of(context).cardColor,),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pair1.toString().toUpperCase()+"USDT",
                                  style: TextStyle(
                                      color: TypeOfColor1(longorshort1),
                                      fontSize: 13
                                  ),
                                ),
                                Text("Cross x"+leverage1.toInt().toString().toUpperCase(),
                                  style: TextStyle(
                                      color: TypeOfColor1(longorshort1),
                                      fontSize: 11
                                  ),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Entry Price",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),
                                ),
                                Text(entryPrice1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Mark Price",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),
                                ),
                                Text(markprice1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),)
                              ],
                            )
                          ]),

                      SizedBox(height: 15),
                      Container(
                        height:40,
                        decoration: BoxDecoration(
                          border:Border.all(width:1,color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                x.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "USDT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height:40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                //width: width/7.1,
                                height: 50,
                                decoration: BoxDecoration(
                                  border:Border.all(width:1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
                                  color: TypeOfColor(button1)
                                ),
                                child: InkWell(
                                  onTap: (){
                                    x=calcul(0.1);
                                    button1=true;
                                    button2=false;
                                    button3=false;
                                    button4=false;
                                    button5=false;
                                    setState((){});
                                  },
                                  child: Center(
                                    child: Text(
                                      "10%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                               // width: width/7.1,
                                height: height*0.06,
                                decoration: BoxDecoration(
                                  border:Border.all(width:1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
                                    color: TypeOfColor(button2)
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      x=calcul(0.25);
                                      button1=false;
                                      button2=true;
                                      button3=false;
                                      button4=false;
                                      button5=false;
                                      setState((){});
                                    },
                                    child: Text(
                                      "25%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                               // width: width/7.1,
                                height: height*0.06,
                                decoration: BoxDecoration(
                                  border:Border.all(width:1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
                                    color: TypeOfColor(button3)
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      x=calcul(0.5);
                                      button1=false;
                                      button2=false;
                                      button3=true;
                                      button4=false;
                                      button5=false;
                                      setState((){});
                                    },
                                    child: Text(
                                      "50%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                //width: width/7.1,
                                height: height*0.06,
                                decoration: BoxDecoration(
                                  border:Border.all(width:1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
                                    color: TypeOfColor(button4)
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      x=calcul(0.75);
                                      button1=false;
                                      button2=false;
                                      button3=false;
                                      button4=true;
                                      button5=false;
                                      setState((){});
                                    },
                                    child: Text(
                                      "75%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                //width: width/7,
                                height: height*0.06,
                                decoration: BoxDecoration(
                                  border:Border.all(width:1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
                                    color: TypeOfColor(button5)
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      x=calcul(1);
                                      button1=false;
                                      button2=false;
                                      button3=false;
                                      button4=false;
                                      button5=true;
                                      setState((){});
                                    },
                                    child: Text(
                                      "100%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PNL",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                          Text(
                            deuxchiffre(unrealizedpnl(entryPrice1,markprice1,longorshort1,leverage1,true)).toString()+" USDT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: width*0.5,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xff246EE9),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty
                              .all(Color(0xff246EE9))),
                          onPressed: () async {
                            try {
                              _rewardedAd.show(
                                  onUserEarnedReward: (AdWithoutView ad,
                                      RewardItem item) async {
                                    //_loadRewardedAd();
                                    update_user();
                                  });
                            }catch(e){_loadRewardedAd();}
                            await Getcontact();
                            double m = 0;
                            if(button1==true){m=0.1;}
                            if(button2==true){m=0.25;}
                            if(button3==true){m=0.5;}
                            if(button4==true){m=0.75;}
                            if(button5==true){m=1;}
                            if(button1==true || button2==true ||button3==true ||button4==true ||button5==true){
                              if(button5==true){
                                String p =calcul(m);
                                print(p);
                                print(" ---------- position -----------");
                                double pnl = unrealizedpnl(entryPrice1,markprice1,longorshort1,leverage1,true)/100*quantity1;
                                UpdateContactDouble1("day7",pnl);
                                await UpdateContactDouble("wallet", h+double.parse(p));
                                await UpdateContactString(entryPrice, "0");
                                await UpdateContactString(takeprofit, "0");
                                await UpdateContactString(stoploss, "0");
                                await  UpdateContactDouble(quantity, 0.0);
                                await  UpdateContactDouble(liqprice, 0.0);
                                await  UpdateContactDouble("nombreoftrade",1);
                                await UpdateContactBoolean(position, false);
                                Navigator.pop(context);
                              }
                              else{
                                double quantityy=quantity1-quantity1*m;
                                String p =calcul(m);
                                print(p);
                                await  UpdateContactDouble(quantity, quantityy);
                                await UpdateContactDouble("wallet", h+double.parse(p));
                                double pnl = unrealizedpnl(entryPrice1,markprice1,longorshort1,leverage1,true)/100*quantity1;
                                UpdateContactDouble1("day7",pnl*m);
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text(
                              "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );

              },
            ),
        );
      }
  );




}






TypeOfColor1(bool x) {
  if (x == true) {
    return Colors.green;
  }
  else if (x == false) {
    return Colors.red;
  }
}
