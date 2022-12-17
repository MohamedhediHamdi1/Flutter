import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import '../liqprice.dart';
import 'addtowallet.dart';


class Market_position extends StatefulWidget {
final double leverage;
final String pair;
final String isolated_cross;
  const Market_position({Key? key,required this.leverage , required this.pair,required this.isolated_cross}) : super(key: key);


  @override
  State<Market_position> createState() => new _Market_positionState(leverage,pair,isolated_cross);
}

class _Market_positionState extends State<Market_position> {
  var size, height, width;

  /*----------------------------------------------------------------------*/
  final text11Controller = TextEditingController();
  final text12Controller = TextEditingController();
  bool TPSLerreur =false;
  double sizeusdt = 0.0;
  String api = "192.168.1.105";
  String buyorsell1 = "Long";
  String buyorsell2 = "Long";
  String buyorsell3 = "Long";
  String btcUsdtPrice ="0";

  String markprice1 = "0";
  String markprice2 = "0";
  String markprice3 = "0";
  double liqprice1 = 0.0;
  double liqprice2 = 0.0;
  double liqprice3 = 0.0;
  double quantity1 = 0.0;
  double quantity2 = 0.0;
  double quantity3 = 0.0;
  bool longorshort1 = true;
  bool longorshort2 = true;
  bool longorshort3 = true;
  String entryPrice1 = "0";
  String entryPrice2 = "0";
  String entryPrice3 = "0";
  double wallet = 0.0;
  double leverage1 = 0.0;
  double leverage2 = 0.0;
  double leverage3 = 0.0;
  String pair1 = "btc";
  String pair2 = "btc";
  String pair3 = "btc";
  bool position1 = false;
  bool position2 = false;
  bool position3 = false;
  bool order1 = false;
  bool order2 = false;
  bool order3 = false;
  String stopLoss2 = "0";
  String stopLoss3 = "0";
  String stopLoss1 = "0";
  String takeProfit1 = "0";
  String takeProfit2 = "0";
  String takeProfit3 = "0";

  String pnlp1 = "0";
  String pnl1 = "0";
  String pnlp2 = "0";
  String pnl2 = "0";
  String pnlp3 = "0";
  String pnl3 = "0";
  Color pnlc1 = Colors.white;
  Color pnlc2 = Colors.white;
  Color pnlc3 = Colors.white;


  var price = 0.0;
  var name = 'Coin Name';
  var symbol = 'Symbol';
  double _Value = 25;

  String selctedcrypto = "btc";
  int selectedmaxleverage = 125;

  double selectedmaxleverage2 = 25;
  double selectedmaxleverage4 = 50;
  double selectedmaxleverage6 = 75;
  double selectedmaxleverage8 = 100;
  bool TPSLcheckbox = false;
  bool Reduceonlycheckbox = false;
  int orderitemcount = 0;
  int positionitemcount=0;
  bool order1visibility = false;
  bool order2visibility = false;
  bool order3visibility = false;
  String order1price = "0";

  String order2price = "0";

  String order3price = "0";

  String order1time = "ffff";
  String order2time = "ffff";
  String order3time = "ffff";



  final text8Controller = TextEditingController();
  final text9Controller = TextEditingController();
  final text3Controller = TextEditingController();
  final text4Controller = TextEditingController();
  final text5Controller = TextEditingController();
  final text6Controller = TextEditingController();
  final text7Controller = TextEditingController();
  final text10Controller = TextEditingController();

  String sizecurency = "USDT";



 double leverage;
 String pair;
 String isolated_cross;
bool x=true;
  _Market_positionState(this.leverage,this.pair,this.isolated_cross);
  /*----------------------------------------------------------------------*/



  @override
  Widget build(BuildContext context) {
    if(x==true){
      Getcontact_OnOpen();
      x=false;
    }
    String size1= deuxchiffre((wallet*sizeusdt/100*leverage)).toString();
    size = MediaQuery
        .of(context)
        .size;
    height = size.height;
    width = size.width;
    return Column(
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(width: 33),
            Text("Avbl", style: TextStyle(color: Theme
                .of(context)
                .cardColor),),
            SizedBox(width: 10),
            Text(deuxchiffre(wallet).toString() + "USDT", style: TextStyle(
                color: Colors.white, fontSize: 15),),
            SizedBox(width: 5),
            InkWell(
              onTap: () async {await showDialogBox(context);Getcontact_OnOpen();},
              child: Icon(
                  Icons.add_box, color: Color(0xff246EE9),
                  size: 20),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(5)),
            color: Color(0xff2b3139),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween,
            children: [
              Container(
                width: width * 0.55,
                child: TextFormField(
                  controller: text10Controller,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (text10Controller){
                    size1=text10Controller;
                  },
                  decoration: InputDecoration(
                    hintText: "size",
                    hintStyle: TextStyle(
                        fontSize: 18, color: Theme
                        .of(context)
                        .cardColor),
                    border: InputBorder.none,
                  ),
                  cursorColor: Color(0xff246EE9),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly
                  ],

                ),
              ),
              Text(sizeusdt.round().toString() + " %",
                style: TextStyle(
                  color: Colors.white,),),
              InkWell(
                onTap: () {
                  if (sizecurency == "USDT") {
                    sizecurency = "BTC";
                  }
                  else {
                    sizecurency = "USDT";
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    Text("$sizecurency",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17),),
                    SizedBox(width: 2,),
                    Icon(Icons.rotate_left,
                      color: Colors.white, size: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Text(
              "Size : "+deuxchiffre((wallet*sizeusdt/100)).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
          width: width * 0.95,
          child: StatefulBuilder(
            builder: (context, set) {
              return Stack(
                children: [
                  Container(
                    width: width * 0.95,
                    child: SliderTheme(
                      data: SliderThemeData(
                        inactiveTickMarkColor: Color(0xff246EE9),
                        activeTickMarkColor: Colors.red,
                        trackHeight: 5,
                      ),
                      child: Slider(
                        autofocus: true,
                        value: sizeusdt,
                        label: sizeusdt.round()
                            .toString(),
                        activeColor: Colors.grey[600],
                        min: 0,
                        max: 100,
                        divisions: selectedmaxleverage -
                            1,
                        onChanged: (double e) {
                          sizeusdt = e;
                          text10Controller.text=deuxchiffre(e*wallet*leverage/100).toString();
                          setState(() {});
                        },

                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(onPressed: () {
                        sizeusdt = 0;
                        text10Controller.text="0";
                        setState(() {});
                        _Value = 1;
                      },
                        icon: Icon(Icons.circle,
                          color: Colors.grey,
                          size: 15,),),
                      Text("   0%", style: TextStyle(
                          fontSize: 14,
                          color: Colors.white),),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.203, 0, 0, 0),
                      child: Column(
                        children: [
                          IconButton(onPressed: () {
                            sizeusdt=25.0;
                            text10Controller.text=deuxchiffre(0.25*wallet*leverage).toString();
                            setState(() {});
                            _Value = 25.0;
                          },
                              icon: Icon(Icons.circle,
                                color: Colors.grey,
                                size: 15,)),
                          Text("  25%",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white),),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.413, 0, 0, 0),
                      child: Column(
                        children: [
                          IconButton(onPressed: () {
                            sizeusdt=50.0;
                            text10Controller.text=deuxchiffre(0.5*wallet*leverage).toString();
                            setState(() {});
                            _Value =
                            50.0;
                          },
                              icon: Icon(Icons.circle,
                                color: Colors.grey,
                                size: 15,)),
                          Text("  50%",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white),),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.623, 0, 0, 0),
                      child: Column(
                        children: [
                          IconButton(onPressed: () {
                            sizeusdt=75.0;
                            text10Controller.text=deuxchiffre(0.75*wallet*leverage).toString();
                            setState(() {});
                            _Value =75.0;
                          },
                              icon: Icon(Icons.circle,
                                color: Colors.grey,
                                size: 15,)),
                          Text("  75%",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white),),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.833, 0, 0, 0),
                      child: Column(
                        children: [
                          IconButton(onPressed: () {
                            sizeusdt=100.0;
                            text10Controller.text=deuxchiffre(wallet*leverage).toString();
                            setState(() {});
                            _Value = 100.0;
                          },
                              icon: Icon(Icons.circle,
                                color: Colors.grey,
                                size: 15,)),
                          Text(" 100%",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white),),
                        ],
                      )
                  ),
                ],
              );
            },),
        ),
        SizedBox(height: 18),
        Divider(color: Theme
            .of(context)
            .cardColor,
            endIndent: width * 0.04,
            indent: width * 0.05,
            thickness: 0.4,
            height: 10),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize
                  .shrinkWrap,
              value: TPSLcheckbox,
              onChanged: (er) {
                TPSLcheckbox = er!;
                setState(() {});
                if (Reduceonlycheckbox = true) {
                  Reduceonlycheckbox =
                  !Reduceonlycheckbox;
                };
              },
              activeColor: Color(0xff246EE9),
              checkColor: Theme
                  .of(context)
                  .backgroundColor,
            ),
            Text("TP/SL", style: TextStyle(
                fontSize: 15, color: Colors.white),),
          ],
        ),
        Visibility(
          visible: true,
          child: Container(
            width: width,
            height: 120,
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 0),
                  padding: EdgeInsets.fromLTRB(
                      15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(5)),
                    color: Color(0xff2b3139),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Container(
                        width: width * 0.6,
                        child: TextFormField(
                          controller: text11Controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Take Profit",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Theme
                                    .of(context)
                                    .cardColor),
                            border: InputBorder.none,
                          ),
                          cursorColor: Color(0xff246EE9),
                          keyboardType: TextInputType
                              .number,
                          inputFormatters: <
                              TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly
                          ],

                        ),
                      ),
                      Row(
                        children: [
                          Text("   USDT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17)),
                        ],
                      ),
                    ],
                  ),

                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 0),
                  padding: EdgeInsets.fromLTRB(
                      15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(5)),
                    color: Color(0xff2b3139),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Container(
                        width: width * 0.6,
                        child: TextFormField(
                          controller: text12Controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Stop Loss",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Theme
                                    .of(context)
                                    .cardColor),
                            border: InputBorder.none,
                          ),
                          cursorColor: Color(0xff246EE9),
                          keyboardType: TextInputType
                              .number,
                          inputFormatters: <
                              TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly
                          ],

                        ),
                      ),
                      Row(
                        children: [
                          Text("   USDT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17)),
                        ],
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize
                    .shrinkWrap,
                value: Reduceonlycheckbox,
                onChanged: (er) {
                  Reduceonlycheckbox = er!;
                  setState(() {});
                  if (TPSLcheckbox = true) {
                    TPSLcheckbox = !TPSLcheckbox;
                  };
                },
                activeColor: Color(0xff246EE9),
                checkColor: Theme
                    .of(context)
                    .backgroundColor,
              ),
              Text("Reduce-Only", style: TextStyle(
                  fontSize: 15, color: Colors.white),),
            ],
          ),
        ),

        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly,
          children: [
            Container(
              width: width * 0.43,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty
                      .all(Colors.green),
                ),
                onPressed: () async {
                  await buy_sell(true);
                  setState(() {});
                }

                , child: Text("Buy/Long"),
              ),
            ),
            Container(
              width: width * 0.43,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty
                      .all(Colors.red),
                ),
                onPressed: () async {
                  await buy_sell(false);
                  setState(() {});
                }
                , child: Text("Sell/Short"),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Future<void> buy_sell(bool x) async {
    if (order1 == false && position1== false ) {
      await streamListener(widget.pair);
      print(btcUsdtPrice);
      await UpdateContactString(
          "entryPrice1",
          "16000");
      await UpdateContactString(
          "pair1", widget.pair);
      await UpdateContactDouble(
          "leverage1", widget.leverage);
      await UpdateContactBoolean(
          "longorshort1", x);
      await UpdateContactDouble(
          "quantity1", deuxchiffre((wallet*sizeusdt/100)*0.993));
      await UpdateContactDouble(
          "wallet", deuxchiffre(wallet-(wallet*sizeusdt/100)));;
      if(TPSLcheckbox==true){
        UpdateContactString(
            "takeProfit1", text11Controller.text);
        UpdateContactString(
            "stopLoss1", text12Controller.text);
      }
      await UpdateContactBoolean(
          "position1", true);
      await Getcontact_OnOpen();
      liqprice1=liquidation_price(longorshort1,isolated__cross(isolated_cross),double.parse(entryPrice1),selectedmaxleverage,leverage1,wallet,quantity1);
    }
    else if (order2 == false && position2== false) {
      await UpdateContactString(
          "entryPrice2",
          text7Controller.text);
      await UpdateContactString(
          "pair2", widget.pair);
      await UpdateContactDouble(
          "leverage2", widget.leverage);
      await UpdateContactBoolean(
          "longorshort2", x);
      await UpdateContactDouble(
          "quantity2", deuxchiffre((wallet*sizeusdt/100)*0.993));
      await UpdateContactDouble(
          "wallet", deuxchiffre(wallet-(wallet*sizeusdt/100)));;
      if(TPSLcheckbox==true){
        UpdateContactString(
            "takeProfit2", text11Controller.text);
        UpdateContactString(
            "stopLoss2", text12Controller.text);
      }
      await UpdateContactBoolean(
          "Position2", true);
      await Getcontact_OnOpen();
      liqprice2=liquidation_price(longorshort2,isolated__cross(isolated_cross),double.parse(entryPrice2),selectedmaxleverage,leverage2,wallet,quantity2);
    }
    else if (order3 == false && position3 == false) {
      await UpdateContactString(
          "entryPrice3",
          text7Controller.text);
      await UpdateContactString(
          "pair3", widget.pair);
      await UpdateContactDouble(
          "leverage3", widget.leverage);
      await UpdateContactBoolean(
          "longorshort3", x);
      await UpdateContactDouble(
          "quantity3", deuxchiffre((wallet*sizeusdt/100)*0.993));
      await UpdateContactDouble(
          "wallet", deuxchiffre(wallet-(wallet*sizeusdt/100)));;
      if(TPSLcheckbox==true){
        UpdateContactString(
            "takeProfit3", text11Controller.text);
        UpdateContactString(
            "stopLoss3", text12Controller.text);
      }
      await UpdateContactBoolean(
          "Position3", true);
      await Getcontact_OnOpen();
      liqprice3=liquidation_price(longorshort3,isolated__cross(isolated_cross),double.parse(entryPrice3),selectedmaxleverage,leverage3,wallet,quantity3);
    };
  }

  Future Getcontact_OnOpen() async {
    String url = "http://" + api +
        ":8011/contacts/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
    var res = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJZb3NyeTIyMiIsImV4cCI6MTY2OTEyNDc5Nn0.d2CLMdymyw-7w5fdY8bs0wvwE47YMiK9-2xtTnOqSyJ8IwaGTxGAbMYlZK3epinfjte3ipw3-LMRZAec4dWH-Q',
      },
    );
    if (res.statusCode == 200) {
      print("connected");
      //print(res.body);
      var jsonData = json.decode(res.body);
      stopLoss1 = jsonData["stopLoss1"];
      stopLoss2 = jsonData["stopLoss2"];
      stopLoss3 = jsonData["stopLoss3"];
      liqprice1 = jsonData["liqprice1"];
      liqprice2 = jsonData["liqprice2"];
      liqprice3 = jsonData["liqprice3"];
      quantity1 = jsonData["quantity1"];
      quantity2 = jsonData["quantity2"];
      quantity3 = jsonData["quantity3"];
      longorshort1 = jsonData["longorshort1"];
      longorshort2 = jsonData["longorshort2"];
      longorshort3 = jsonData["longorshort3"];
      takeProfit1 = jsonData["takeProfit1"];
      takeProfit2 = jsonData["takeProfit2"];
      takeProfit3 = jsonData["takeProfit3"];
      entryPrice1 = jsonData["entryPrice1"];
      entryPrice2 = jsonData["entryPrice2"];
      entryPrice3 = jsonData["entryPrice3"];
      wallet = jsonData["wallet"];
      leverage1 = jsonData["leverage1"];
      leverage2 = jsonData["leverage2"];
      leverage3 = jsonData["leverage3"];
      pair1 = jsonData["pair1"];
      pair2 = jsonData["pair2"];
      pair3 = jsonData["pair3"];
      order1 = jsonData["order1"];
      order2 = jsonData["order2"];
      order3 = jsonData["order3"];
      order1time = jsonData["order1time"];
      order2time = jsonData["order2time"];
      order3time = jsonData["order2time"];
      position1 = jsonData["position1"];
      position2 = jsonData["position2"];
      position3 = jsonData["position3"];
    }
  }
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

}



double deuxchiffre(double x) {
  int s = ((x - x.roundToDouble()) * 100).toInt();
  double n = x.roundToDouble();
  if (s >= 50) {
    n = n - 1;
  }
  return n + s / 100;
}

Future UpdateContactBoolean(String parametre, bool bool) async {
  String url = "http://" + api +
      ":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
  var res = await http.put(Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJZb3NyeTIyMiIsImV4cCI6MTY2OTEyNDc5Nn0.d2CLMdymyw-7w5fdY8bs0wvwE47YMiK9-2xtTnOqSyJ8IwaGTxGAbMYlZK3epinfjte3ipw3-LMRZAec4dWH-Q',
      },
      body: json.encode({parametre: bool}));
  print(res.statusCode);
  if (res.statusCode == 202) {
    print("updatedd");
  }
}

Future UpdateContactString(String parametre, String string) async {
  String url = "http://" + api +
      ":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
  var res = await http.put(Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJZb3NyeTIyMiIsImV4cCI6MTY2OTEyNDc5Nn0.d2CLMdymyw-7w5fdY8bs0wvwE47YMiK9-2xtTnOqSyJ8IwaGTxGAbMYlZK3epinfjte3ipw3-LMRZAec4dWH-Q',
      },
      body: json.encode({parametre: string}));
  print(res.statusCode);
  if (res.statusCode == 202) {
    print("updated");
  }
}

Future UpdateContactDouble(String parametre, double double) async {
  String url = "http://" + api +
      ":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
  var res = await http.put(Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJZb3NyeTIyMiIsImV4cCI6MTY2OTEyNDc5Nn0.d2CLMdymyw-7w5fdY8bs0wvwE47YMiK9-2xtTnOqSyJ8IwaGTxGAbMYlZK3epinfjte3ipw3-LMRZAec4dWH-Q',
      },
      body: json.encode({parametre: double}));
  print(res.statusCode);
  if (res.statusCode == 202) {
    print("updated");
  }
}

Color unrealizedpnl_color(double x) {
  if (x < 0) {
    return Colors.red;
  }
  else if (x == 0) {
    return Colors.white;
  }
  else {
    return Colors.green;
  }
}

double unrealizedpnl(String entryprice, String markprice, bool longorshort,
    double leverage, bool position) {
  if (position == true) {
    double x = double.parse(entryprice);
    double y = double.parse(markprice);
    int s = ((((y - x) / x * leverage * 100) -
        ((y - x) / x * leverage * 100).roundToDouble()) * 100).toInt();
    double n = ((y - x) / x * leverage * 100).roundToDouble();
    if (s >= 50) {
      n = n - 1;
    }
    if (longorshort == true) {
      return (n + s / 100) / 100;
    }
    else {
      return -(n + s / 100) / 100;
    };
  }
  else {
    return 0.0;
  }
}

String verifytrueorfalse(bool position, String x) {
  if (position == true) {
    return x;
  }
  else {
    return "x";
  }
}

bool isolated__cross(String isolatedcross){
  if(isolatedcross=="Isolated"){return true;}
  else{return false;}
}


