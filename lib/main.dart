import 'package:cryptoo/screens/check_nb_of_position.dart';
import 'package:cryptoo/screens/check_size.dart';
import 'package:cryptoo/screens/staticscreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:cryptoo/admob/adReward.dart';
import 'package:cryptoo/screens/checkEntryprice.dart';
import 'package:cryptoo/screens/limitmarketinfo.dart';
import 'package:cryptoo/screens/profile.dart';
import 'package:cryptoo/screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cryptoo/screens/addtowallet.dart';
import 'package:cryptoo/screens/closeDialogBox.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'Cryptolist.dart';
import 'admob/update_user.dart';
import 'connect.dart';
import 'disconnect.dart';
import 'liqprice.dart';

void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme
              .of(context)
              .textTheme,
        ),
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff474d57),
        backgroundColor: Color(0xff171e26),
        cardColor: Color(0xffb7bdc6),
        buttonColor: Color(0xfff0b90b),
        canvasColor: Color(0xff1f2630),
      ),

      home: SignInScreen(),

    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin ,  WidgetsBindingObserver {
  late RewardedAd _rewardedAd;
  bool check_rewardedAd=false;
  int run_rewardedAd=150;
  String btcUsdtPrice = "0";
  String ethUsdtPrice = "0";


  static List<Cryptolistusdt> Cryptolist = [
    Cryptolistusdt("btc", 1, 125, "btc"),
    Cryptolistusdt("eth", 2, 100, "eth"),
    Cryptolistusdt("bnb", 3, 50, "bnb"),
    Cryptolistusdt("ada", 4, 50, "ada"),
    Cryptolistusdt("xrp", 5, 50, "ada"),
    Cryptolistusdt("doge", 6, 25, "ada"),
    Cryptolistusdt("1000shib", 7, 25, "ada"),
  ];

  List<Cryptolistusdt> display_list = List.from(Cryptolist);

  void Updatelist(String value) {
    setState(() {
      display_list = Cryptolist.where((element) =>
          element.movie_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
  final storage = new FlutterSecureStorage();
  String? token ="";
  String? contact_id ="";
  String? user_id ="";
  int tabbar = 0;
  int stop_test = 0;
  bool TPSLerreur =false;
  double sizeusdt = 0.0;
  double size_usdt = 0.0;
  String api = ConstantVar.api;
  //String api = "192.168.1.105";
  String buyorsell1 = "Long";
  String buyorsell2 = "Long";
  String buyorsell3 = "Long";
  String buyorsell4 = "Long";
  int check_int=0;
  bool check_int_isopen=false;

  String markprice1 = "0";
  String markprice2 = "0";
  String markprice3 = "0";
  String markprice4 = "0";
  double liqprice1 = 0.0;
  double liqprice2 = 0.0;
  double liqprice3 = 0.0;
  double liqprice4 = 0.0;
  double quantity1 = 0.0;
  double quantity2 = 0.0;
  double quantity3 = 0.0;
  double quantity4 = 0.0;
  bool longorshort1 = true;
  bool longorshort2 = true;
  bool longorshort3 = true;
  bool longorshort4 = true;
  String entryPrice1 = "0";
  String entryPrice2 = "0";
  String entryPrice3 = "0";
  String entryPrice4 = "0";
  double wallet = 0.0;
  double leverage1 = 0.0;
  double leverage2 = 0.0;
  double leverage3 = 0.0;
  double leverage4 = 0.0;
  String pair1 = "btc";
  String pair2 = "btc";
  String pair3 = "btc";
  String pair4 = "btc";
  bool position1 = false;
  bool position2 = false;
  bool position3 = false;
  bool position4 = false;
  bool order1 = false;
  bool order2 = false;
  bool order3 = false;
  bool order4 = false;
  String stopLoss2 = "0";
  String stopLoss3 = "0";
  String stopLoss1 = "0";
  String stopLoss4 = "0";
  String takeProfit1 = "0";
  String takeProfit2 = "0";
  String takeProfit3 = "0";
  String takeProfit4 = "0";
  bool typeoftrade1=true;
  bool typeoftrade2=true;
  bool typeoftrade3=true;
  bool typeoftrade4=true;

  String pnlp1 = "0";
  String pnlp4 = "0";
  String pnl1 = "0";
  String pnl4 = "0";
  String pnlp2 = "0";
  String pnl2 = "0";
  String pnlp3 = "0";
  String pnl3 = "0";
  Color pnlc1 = Colors.white;
  Color pnlc4 = Colors.white;
  Color pnlc2 = Colors.white;
  Color pnlc3 = Colors.white;


  var price = 0.0;
  var name = 'Coin Name';
  var symbol = 'Symbol';
  var size, height, width;
  var isolated_cross = "Isolated";
  double _Value = 10;
  double leverage = 10;

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
  bool order4visibility = false;
  String order1price = "0";

  String order2price = "0";

  String order3price = "0";

  String order1time = "ffff";
  String order2time = "ffff";
  String order3time = "ffff";
  String order4time = "ffff";

  late TabController _tabController = TabController(length: 2, vsync: this);
  late TabController _tabController2 = TabController(length: 2, vsync: this);

  final CustomTimerController _controller = CustomTimerController();
  DateTime dateTime = DateTime.now();
  int date11 = 0;
  int streamListener_int=0;



  final text8Controller = TextEditingController();
  final text9Controller = TextEditingController();
  final text3Controller = TextEditingController();
  final text4Controller = TextEditingController();
  final text5Controller = TextEditingController();
  final text6Controller = TextEditingController();
  final text7Controller = TextEditingController();
  final text10Controller = TextEditingController();
  final text11Controller = TextEditingController();
  final text12Controller = TextEditingController();
  final text20Controller = TextEditingController();
  final text21Controller = TextEditingController();



  String sizecurency = "USDT";
 // final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {

    size = MediaQuery
        .of(context)
        .size;
    height = size.height;
    width = size.width;
    //double height3 =height * 0.63;
    double checkheight(bool x){
      if(tabbar==0) {
        if (x == true) {
          return  440 + 120;
        }
        else {
          return  440;
        };
      }
      else if(tabbar==1){return 500;}
      else {return 620;}
    }
    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: SafeArea(
            child: Container(
              width: width * 0.6,
              color: Theme
                  .of(context)
                  .backgroundColor,
              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Derivatives",
                    style: TextStyle(fontSize: 24, color: Colors.white),),

                  Container(
                    height: 35,
                    margin: EdgeInsets.fromLTRB(0, 15, 10, 0),
                    child: TextField(
                      onChanged: (value) => Updatelist(value),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme
                            .of(context)
                            .primaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white38,),
                        hintText: "search",
                        hintStyle: TextStyle(color: Colors.white38, height: 2.5),
                      ),
                    ),

                  ),
                  SizedBox(height: 10,),
                  Expanded(child: ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: (context, index) =>
                        MaterialButton(onPressed: () async {
                          selctedcrypto = display_list[index].movie_title!;
                          selectedmaxleverage = display_list[index].rating!;
                          selectedmaxleverage2 = selectedmaxleverage * 0.2;
                          selectedmaxleverage4 = selectedmaxleverage * 0.4;
                          selectedmaxleverage6 = selectedmaxleverage * 0.6;
                          selectedmaxleverage8 = selectedmaxleverage * 0.8;
                          leverage = 10;
                          btcUsdtPrice="0";
                          await storage.write(key: "leverage", value: "$leverage");
                          await storage.write(key: "selectedmaxleverage", value: "$selectedmaxleverage");
                          await storage.write(key: "pair", value: selctedcrypto);
                          setState(() {});
                          Scaffold.of(context).closeDrawer();
                        },
                          child: ListTile(
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((display_list[index].movie_title!).toUpperCase()+"USDT",
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),
                              ],
                            ),
                            subtitle: Text("Perpetual",style: TextStyle(fontSize: 12,color:Theme.of(context).cardColor),),

                            contentPadding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            /*trailing: Text("${display_list[index].rating}",
                              style: TextStyle(color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),),*/
                          ),
                        ),
                  ),
                  ),
                ],

              ),
            ),
          ),
        ),

        body:  RefreshIndicator(

          onRefresh: ()async{await Getcontact_OnOpen();setState((){});} ,
          child: SafeArea(
            child: Container(
              color: Theme
                  .of(context)
                  .backgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*   */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Builder(builder: (context) =>
                                    InkWell(
                                        child: Row(
                                            children: [
                                              SizedBox(width: 3),
                                              Icon(Icons.menu_open_sharp, size:30,
                                                color: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text(selctedcrypto.toUpperCase()+"USDT", style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),),
                                              Container(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Text(": "+btcUsdtPrice, style: TextStyle(color: Colors.white, fontSize: 16),),
                                              ),
                                            ],
                                        ),
                                        onTap: () => Scaffold.of(context).openDrawer()
                                    ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding:EdgeInsets.fromLTRB(40, 0, 0, 3),
                                  child: Text("Perpetual", style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 15,
                                  ),),
                                ),
                              ],
                            ),
                           ],

                            ),
                        Container(
                          margin:EdgeInsets.only(right:10),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff246EE9),
                            foregroundColor: Colors.red ,
                            radius: 18 ,
                            child: CircleAvatar(
                              radius:16,
                                 backgroundColor: Theme.of(context).backgroundColor,
                                 child: InkWell(
                                onTap: ()async{
                                  stop_test=8;
                                  setState(() {});

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return profile();
                                      }));
                                },
                                child:Center(child: Icon(Icons.person,color: Colors.white,size:30)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                        SizedBox(height: 3,),

                      //crossAxisAlignment: CrossAxisAlignment.start,

                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)), color: Theme.of(context).canvasColor),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: width * 0.22,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Theme
                                        .of(context)
                                        .primaryColor,),
                                    child: DropdownButton(

                                      elevation: 0,
                                      icon: Icon(Icons.arrow_drop_down, size: 20,
                                        color: Colors.white,),
                                      underline: Container(),
                                      items: ["Isolated", "Cross"].map((e) =>
                                          DropdownMenuItem(
                                            child: Text("$e", style: TextStyle(
                                                color: Colors.white,
                                                backgroundColor: Color(0xff474d57),
                                                fontSize: 15),),
                                            value: e,
                                            alignment: Alignment.center,
                                          )
                                      ).toList(),
                                      onChanged: (String? val) {
                                        setState(() {
                                          isolated_cross = val!;
                                          print(isolated_cross);
                                        });
                                      },
                                      value: isolated_cross,
                                      dropdownColor: Color(0xff474d57),
                                      isExpanded: true,
                                    ),
                                  ),


                                  MaterialButton(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: width * 0.14,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Theme
                                          .of(context)
                                          .primaryColor,),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Text(leverage.round().toString(),
                                            style: TextStyle(color: Colors.white),),
                                          Icon(Icons.arrow_drop_down, size: 20,
                                            color: Colors.white,),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      _Value = leverage;
                                      showModalBottomSheet(context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context, State) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Theme
                                                      .of(context)
                                                      .backgroundColor,
                                                  borderRadius: BorderRadiusDirectional
                                                      .vertical(
                                                      top: Radius.circular(20)),),
                                                height: 280,
                                                width: width,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,

                                                        children: [
                                                          SizedBox(width: 35,),
                                                          Text('Adjuste Leverage',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                            ),
                                                          ),

                                                          IconButton(icon: Icon(
                                                            Icons.close, size: 25,
                                                            color: Theme
                                                                .of(context)
                                                                .cardColor,),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          10, 5, 10, 5),
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              _Value -= 1;
                                                              State(() {});
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              Icons.remove,
                                                              color: Theme
                                                                  .of(context)
                                                                  .cardColor,),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(_Value.round()
                                                                  .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(width: 1,),
                                                              Text("x",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .white),)
                                                            ],
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              if (_Value < 124) {
                                                                setState(() {
                                                                  _Value += 1;
                                                                });
                                                                State(() {});
                                                              };
                                                            },
                                                            icon: Icon(Icons.add,
                                                              color: Theme
                                                                  .of(context)
                                                                  .cardColor,),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          10, 7, 10, 10),
                                                      width: width * 0.95,
                                                      child: StatefulBuilder(
                                                        builder: (context, set) {
                                                          return Stack(
                                                            children: [

                                                              Container(
                                                                width: width *
                                                                    0.95,
                                                                child: SliderTheme(
                                                                  data: SliderThemeData(
                                                                    disabledActiveTickMarkColor: Colors.transparent,disabledInactiveTickMarkColor: Colors.transparent,
                                                                    inactiveTickMarkColor: Colors.transparent,
                                                                    activeTickMarkColor: Colors.transparent,
                                                                    trackHeight: 3,
                                                                  ),
                                                                  child: Slider(
                                                                    autofocus: true,
                                                                    thumbColor:Color(0xff246EE9) ,
                                                                    value: _Value,
                                                                    label: _Value
                                                                        .round()
                                                                        .toString(),
                                                                    activeColor: Color(0xff246EE9),
                                                                    min: 1,
                                                                    max: selectedmaxleverage
                                                                        .toDouble(),
                                                                    divisions: selectedmaxleverage -
                                                                        1,
                                                                    onChanged: (
                                                                        double e) {
                                                                      _Value = e;
                                                                      set(() {});
                                                                      State(() {});
                                                                    },

                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  IconButton(
                                                                    onPressed: () {
                                                                      State(() {});
                                                                      _Value = 1;
                                                                      set(() {});
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .circle,
                                                                      color: Color(0xff246EE9),
                                                                      size: 15,),),
                                                                  Text(" 1x",
                                                                    style: TextStyle(
                                                                        fontSize: 15,
                                                                        color: Colors
                                                                            .white),),
                                                                ],
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      width *
                                                                          0.16, 0,
                                                                      0, 0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            State(() {});
                                                                            _Value =
                                                                                selectedmaxleverage *
                                                                                    0.2;
                                                                            set(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            Icons
                                                                                .circle,
                                                                            color: Color(0xff246EE9),
                                                                            size: 15,)),
                                                                      Text(
                                                                        selectedmaxleverage2
                                                                            .round()
                                                                            .toString() +
                                                                            "x",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors
                                                                                .white),),
                                                                    ],
                                                                  )
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      width *
                                                                          0.328,
                                                                      0, 0, 0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            State(() {});
                                                                            _Value =
                                                                                selectedmaxleverage *
                                                                                    0.4;
                                                                            set(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            Icons
                                                                                .circle,
                                                                            color: Color(0xff246EE9),
                                                                            size: 15,)),
                                                                      Text(
                                                                        selectedmaxleverage4
                                                                            .round()
                                                                            .toString() +
                                                                            "x",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors
                                                                                .white),),
                                                                    ],
                                                                  )
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      width *
                                                                          0.496,
                                                                      0, 0, 0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            State(() {});
                                                                            _Value =
                                                                                selectedmaxleverage *
                                                                                    0.6;
                                                                            set(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            Icons
                                                                                .circle,
                                                                            color: Color(0xff246EE9),
                                                                            size: 15,)),
                                                                      Text(
                                                                        selectedmaxleverage6
                                                                            .round()
                                                                            .toString() +
                                                                            "x",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors
                                                                                .white),),
                                                                    ],
                                                                  )
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      width *
                                                                          0.666,
                                                                      0, 0, 0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            State(() {});
                                                                            _Value =
                                                                                selectedmaxleverage *
                                                                                    0.8;
                                                                            set(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            Icons
                                                                                .circle,
                                                                            color: Color(0xff246EE9),
                                                                            size: 15,)),
                                                                      Text(
                                                                        selectedmaxleverage8
                                                                            .round()
                                                                            .toString() +
                                                                            "x",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors
                                                                                .white),),
                                                                    ],
                                                                  )
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      width *
                                                                          0.833,
                                                                      0, 0, 0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            State(() {});
                                                                            _Value =
                                                                                selectedmaxleverage *
                                                                                    1.0;
                                                                            set(() {});
                                                                          },
                                                                          icon: Icon(
                                                                            Icons
                                                                                .circle,
                                                                            color: Color(0xff246EE9),
                                                                            size: 15,)),
                                                                      Text(
                                                                        selectedmaxleverage
                                                                            .round()
                                                                            .toString() +
                                                                            "x",
                                                                        style: TextStyle(
                                                                            fontSize: 15,
                                                                            color: Colors
                                                                                .white),),
                                                                    ],
                                                                  )
                                                              ),
                                                            ],
                                                          );
                                                        },),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff246EE9),
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      ),
                                                      height: 40,
                                                      margin: EdgeInsets.fromLTRB(
                                                          30, 25, 30, 15),
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            leverage = _Value;
                                                            await storage.write(key: "leverage", value: "$leverage");
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          },

                                                          child: Center(
                                                              child: Text(
                                                                'Confirm',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20),))
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.08,),
                              Container(
                                width: width * 0.25,
                                child: Column(
                                  children: [
                                    Text("Funding/Countdown",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ), maxLines: 1,
                                    ),
                                    CustomTimer(
                                        controller: _controller,
                                        begin: Duration(hours:calculhours(),minutes:60-dateTime.minute,seconds:60-dateTime.second ),
                                        end: Duration(),
                                        builder: (time) {
                                          return Text(
                                              "0.0100% / "+"${time.hours}:${time.minutes}:${time.seconds}",
                                              /*dateTime.minute.toString(),*/
                                              style: TextStyle(fontSize: 10,color: Colors.white)
                                          );
                                        }
                                    )
                                    /*Text("0.0100% / 03:17:53",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ), maxLines: 1,
                                    ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(child: Divider(color: Theme
                              .of(context)
                              .cardColor,
                              endIndent: width * 0.04,
                              indent: width * 0.05,
                              thickness: 0.4,
                              height: 8), height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.4,
                                height: 20,
                                child: TabBar(
                                  onTap: (e) async {

                                    tabbar=e;
                                    setState((){});
                                    await Getcontact_OnOpen();
                                  },
                                  labelPadding: EdgeInsets.all(0),
                                  labelStyle: TextStyle(fontSize: 14),
                                  isScrollable: false,
                                  controller: _tabController,
                                  labelColor: Color(0xff246EE9),
                                  unselectedLabelColor: Theme
                                      .of(context)
                                      .cardColor,
                                  indicator: BoxDecoration(color: Theme
                                      .of(context)
                                      .canvasColor),
                                  tabs: [
                                    Tab(text: "Limit"),
                                    Tab(text: "Market"),
                                    /*Tab(
                                      child: Container(child: Text("Conditional ")),),*/
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: IconButton(onPressed: () {
                                    limit_market_info(context);
                                  },
                                      icon: Icon(Icons.info, size: 17, color: Color(0xff246EE9),))
                              ),
                            ],
                          ),

                          Container(
                            height: checkheight(TPSLcheckbox),
                            width: width,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 10,),
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
                                          onTap: () async {
                                            await showDialogBox(context);
                                            Getcontact_OnOpen();
                                            },
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
                                            width: width * 0.6,
                                            child: TextFormField(
                                              style: const TextStyle(color: Colors.white),
                                              controller: text7Controller,
                                              decoration: InputDecoration(
                                                hintText: "Price",
                                                hintStyle: TextStyle(
                                                    fontSize: 18, color: Theme
                                                    .of(context)
                                                    .cardColor),
                                                border: InputBorder.none,
                                              ),
                                              cursorColor: Color(0xff246EE9),
                                              keyboardType:TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
                                              ],

                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  text7Controller.text=btcUsdtPrice;
                                                  setState(() {});
                                                },
                                                child: Text("LAST",
                                                    style: TextStyle(
                                                        color: Color(0xff246EE9),
                                                        fontSize: 14)),
                                              ),
                                              Text("   USDT", style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17)),
                                            ],
                                          ),
                                        ],
                                      ),

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
                                            width: width * 0.6,
                                            child: TextFormField(
                                                controller: text10Controller,
                                              style: const TextStyle(color: Colors.white),
                                              onChanged: (text10Controller){
                                                  if(text10Controller.isEmpty==true ||text10Controller==null ){sizeusdt=0.0;}
                                                  else {
                                                    if(double.parse(text10Controller)>=wallet*leverage){sizeusdt=100;}
                                                    else if(double.parse(text10Controller)<=0){sizeusdt=0;}
                                                    else{sizeusdt=double.parse(text10Controller)*100/wallet/leverage;}
                                                  }
                                                  setState(() {});
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
                                              keyboardType:TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
                                              ],
                                            ),
                                          ),
                                          Text(sizeusdt.round().toString() + " % ",
                                            style: TextStyle(
                                              color: Colors.white,fontSize: 17),),
                                          Text("$sizecurency",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                            "Margin : "+deuxchiffre((wallet*sizeusdt/100)).toString()+" USDT",
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
                                                    inactiveTickMarkColor: Colors.transparent,
                                                    activeTickMarkColor: Colors.transparent,
                                                    trackHeight: 5,
                                                  ),
                                                  child: Slider(
                                                    autofocus: true,
                                                    value: sizeusdt,
                                                    label: sizeusdt.round()
                                                        .toString(),
                                                    thumbColor: Color(0xff246EE9),
                                                    activeColor: Color(0xff246EE9),
                                                    min: 0,
                                                    max: 100,
                                                    divisions: selectedmaxleverage -
                                                        1,
                                                    onChanged: (e) {
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
                                                      color: Color(0xff246EE9),
                                                      size: 15,),),
                                                  Text("   0%", style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      width * 0.209, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(onPressed: () {
                                                        sizeusdt=25.0;
                                                        text10Controller.text=deuxchiffre(0.25*wallet*leverage).toString();
                                                        setState(() {});
                                                        _Value = 25.0;
                                                      },
                                                          icon: Icon(Icons.circle,
                                                            color: Color(0xff246EE9),
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
                                                      width * 0.417, 0, 0, 0),
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
                                                            color: Color(0xff246EE9),
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
                                                      width * 0.626, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(onPressed: () {
                                                        sizeusdt=75.0;
                                                        text10Controller.text=deuxchiffre(0.75*wallet*leverage).toString();
                                                        setState(() {});
                                                        _Value =75.0;
                                                      },
                                                          icon: Icon(Icons.circle,
                                                            color: Color(0xff246EE9),
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
                                                            color: Color(0xff246EE9),
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
                                      visible: TPSLcheckbox,
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
                                                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
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
                                                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
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
                                              try {
                                                _rewardedAd.show(
                                                    onUserEarnedReward: (
                                                        AdWithoutView ad,
                                                        RewardItem item) async {
                                                      //_loadRewardedAd();
                                                      run_rewardedAd=0;
                                                      update_user();
                                                      if (text7Controller.text
                                                          .isEmpty == false &&
                                                          sizeusdt > 1 &&
                                                          check_entryprice(
                                                              true) == true) {
                                                        await buy_sell(true);
                                                        setState(() {});
                                                      }
                                                      else {
                                                        print(
                                                            "erreur entryprice");
                                                        CheckEntryprice(context);
                                                      }
                                                    });
                                              }catch(e){
                                                if (text7Controller.text
                                                    .isEmpty == false &&
                                                    sizeusdt > 1 &&
                                                    check_entryprice(
                                                        true) == true) {
                                                  await buy_sell(true);
                                                  setState(() {});
                                                }
                                                else {
                                                  print(
                                                      "erreur entryprice");
                                                  CheckEntryprice(context);
                                                }
                                                //_loadRewardedAd();
                                              }
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
                                              try {
                                                _rewardedAd.show(
                                                    onUserEarnedReward: (
                                                        AdWithoutView ad,
                                                        RewardItem item) async {
                                                      //_loadRewardedAd();
                                                      run_rewardedAd=0;
                                                      update_user();
                                                      if (text7Controller.text
                                                          .isEmpty == false &&
                                                          sizeusdt > 1 &&
                                                          check_entryprice(
                                                              false) ==
                                                              true) {
                                                        await buy_sell(false);
                                                        setState(() {});
                                                      }
                                                      else {
                                                        print(
                                                            "erreur entryprice");
                                                        CheckEntryprice(context);
                                                      }
                                                    });
                                              }catch(e){
                                                if (text7Controller.text
                                                    .isEmpty == false &&
                                                    sizeusdt > 1 &&
                                                    check_entryprice(
                                                        false) ==
                                                        true) {
                                                  await buy_sell(false);
                                                  setState(() {});
                                                }
                                                else {
                                                  print(
                                                      "erreur entryprice");
                                                  CheckEntryprice(context);
                                                }
                                                //_loadRewardedAd();
                                              }
                                            }
                                            , child: Text("Sell/Short"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(height:10,),
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
                                            width: width * 0.6,
                                            child: TextFormField(
                                                 controller: text10Controller,
                                              style: const TextStyle(color: Colors.white),
                                              onChanged: (text10Controller){
                                                if(text10Controller.isEmpty==true ||text10Controller==null ){sizeusdt=0.0;}
                                                else {
                                                  if(double.parse(text10Controller)>=wallet*leverage){sizeusdt=100;}
                                                  else if(double.parse(text10Controller)<=0){sizeusdt=0;}
                                                  else{sizeusdt=double.parse(text10Controller)*100/wallet/leverage;}
                                                }
                                                setState(() {});
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
                                              keyboardType:TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
                                              ],

                                            ),
                                          ),
                                          Text(sizeusdt.round().toString() + " % ",
                                            style: TextStyle(
                                              color: Colors.white,fontSize: 17),),
                                          Text("USDT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          "Margin : "+deuxchiffre((wallet*sizeusdt/100)).toString()+" USDT",
                                          style: TextStyle(
                                            color: Theme.of(context).cardColor,
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
                                                    inactiveTickMarkColor: Colors.transparent,
                                                    activeTickMarkColor: Colors.transparent,
                                                    trackHeight: 5,
                                                  ),
                                                  child: Slider(
                                                    autofocus: true,
                                                    value: sizeusdt,
                                                    label: sizeusdt.round()
                                                        .toString(),
                                                    thumbColor: Color(0xff246EE9),
                                                    activeColor: Color(0xff246EE9),
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
                                                      color: Color(0xff246EE9),
                                                      size: 15,),),
                                                  Text("   0%", style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      width * 0.209, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(onPressed: () {
                                                        sizeusdt=25.0;
                                                        text10Controller.text=deuxchiffre(0.25*wallet*leverage).toString();
                                                        setState(() {});
                                                        _Value = 25.0;
                                                      },
                                                          icon: Icon(Icons.circle,
                                                            color: Color(0xff246EE9),
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
                                                      width * 0.417, 0, 0, 0),
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
                                                            color: Color(0xff246EE9),
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
                                                      width * 0.626, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(onPressed: () {
                                                        sizeusdt=75.0;
                                                        text10Controller.text=deuxchiffre(0.75*wallet*leverage).toString();
                                                        setState(() {});
                                                        _Value =75.0;
                                                      },
                                                          icon: Icon(Icons.circle,
                                                            color: Color(0xff246EE9),
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
                                                            color: Color(0xff246EE9),
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
                                                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
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
                                                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
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
                                              try {
                                                _rewardedAd.show(
                                                    onUserEarnedReward: (
                                                        AdWithoutView ad,
                                                        RewardItem item) {
                                                      run_rewardedAd=0;
                                                      //_loadRewardedAd();
                                                    });
                                                update_user();
                                                await buy_sell1(true);
                                                setState(() {});
                                              }catch(e){
                                                await buy_sell1(true);
                                                setState(() {});
                                                //_loadRewardedAd();
                                              }
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
                                              try {
                                                 _rewardedAd.show(
                                                    onUserEarnedReward: (
                                                        AdWithoutView ad,
                                                        RewardItem item) {
                                                      run_rewardedAd=0;
                                                      //_loadRewardedAd();
                                                    });
                                                update_user();
                                                await buy_sell1(false);
                                                setState(() {});
                                              }catch(e){
                                                await buy_sell1(false);
                                                setState(() {});
                                                //_loadRewardedAd();
                                              }
                                            }
                                            , child: Text("Sell/Short"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(17, 20, 0, 10),
                                width: width * 0.5,
                                height: 20,
                                child: TabBar(
                                  labelPadding: EdgeInsets.all(0),
                                  isScrollable: false,
                                  controller: _tabController2,
                                  labelColor: Color(0xff246EE9),
                                  unselectedLabelColor: Theme
                                      .of(context)
                                      .cardColor,
                                  indicator: BoxDecoration(color: Theme
                                      .of(context)
                                      .canvasColor),
                                  tabs: [
                                    Tab(text: "Orders($orderitemcount)"),
                                    Tab(text: "Positions($positionitemcount)"),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Divider(color: Theme
                              .of(context)
                              .cardColor,
                              endIndent: width * 0.04,
                              indent: width * 0.05,
                              thickness: 0.4,
                              height: 8),
                          SizedBox(height: 10),
                          Container(
                            width: width * 0.95,
                            height: 650,
                            child: TabBarView(
                              controller: _tabController2,
                              children: [
                                Column(
                                  children: [
                                    Visibility(
                                      visible: order1,
                                      child: Container(
                                        height: 140,
                                        width: width,
                                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(pair1.toUpperCase()+"USDT Perpetual",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),),
                                                Text("$order1time",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text("Limt/"+buyorsell1, style: TextStyle(
                                                    fontSize: 18,
                                                    color: TypeOfColor(longorshort1)),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 15),
                                                CircleAvatar(
                                                  backgroundColor: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  radius: 20,
                                                  child: CircleAvatar(
                                                    backgroundColor: Theme
                                                        .of(context)
                                                        .backgroundColor,
                                                    radius: 16,
                                                    child: Text("0%",
                                                      style: TextStyle(fontSize: 16,
                                                          color: TypeOfColor(longorshort1)),),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Text("Amont \n(USDT)",
                                                  style: TextStyle(fontSize: 15,
                                                      color: Colors.grey),),
                                                SizedBox(width: 30),
                                                Text("$quantity1", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 75),
                                                Text("Price", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),),
                                                SizedBox(width: 37),
                                                Text("$entryPrice1",
                                                  style: TextStyle(fontSize: 16,
                                                      color: Colors.white),),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .end,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty
                                                                .all(Theme
                                                                .of(context)
                                                                .primaryColor),),
                                                          //Theme.of(context).primaryColor
                                                          onPressed: () async {
                                                            try {
                                                              await UpdateContactString(
                                                                  "takeProfit1",
                                                                  "0");
                                                              await UpdateContactString(
                                                                  "stopLoss1",
                                                                  "0");
                                                              await UpdateContactDouble(
                                                                  "liqprice1",
                                                                  0);
                                                              await UpdateContactDouble(
                                                                  "wallet",
                                                                  wallet +
                                                                      quantity1 *
                                                                          1.007);
                                                              await UpdateContactBoolean(
                                                                  "order1",
                                                                  false);
                                                              order1 = false;
                                                              await UpdateContactString(
                                                                  "entryPrice1",
                                                                  "0");
                                                              entryPrice1 = "0";
                                                              await Getcontact_OnOpen();
                                                              orderitemcount -=
                                                              1;
                                                              setState(() {});
                                                            }catch(e){}
                                                          },
                                                          child: Center(child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: order2,
                                      child: Container(
                                        height: 150,
                                        width: width,
                                        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: order1,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(pair2.toUpperCase()+"USDT Perpetual",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),),
                                                Text("$order2time",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text("Limt/"+buyorsell2, style: TextStyle(
                                                    fontSize: 18,
                                                    color: TypeOfColor(longorshort2)),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 15),
                                                CircleAvatar(
                                                  backgroundColor: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  radius: 20,
                                                  child: CircleAvatar(
                                                    backgroundColor: Theme
                                                        .of(context)
                                                        .backgroundColor,
                                                    radius: 16,
                                                    child: Text("0%",
                                                      style: TextStyle(fontSize: 16,
                                                          color: TypeOfColor(longorshort2)),),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Text("Amont \n(USDT)",
                                                  style: TextStyle(fontSize: 15,
                                                      color: Colors.grey),),
                                                SizedBox(width: 30),
                                                Text("$quantity2", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 75),
                                                Text("Price", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),),
                                                SizedBox(width: 37),
                                                Text("$entryPrice2",
                                                  style: TextStyle(fontSize: 16,
                                                      color: Colors.white),),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .end,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty
                                                                .all(Theme
                                                                .of(context)
                                                                .primaryColor),),
                                                          //Theme.of(context).primaryColor
                                                          onPressed: () async {
                                                            try {
                                                              await UpdateContactString(
                                                                  "takeProfit2",
                                                                  "0");
                                                              await UpdateContactString(
                                                                  "stopLoss2",
                                                                  "0");
                                                              await UpdateContactDouble(
                                                                  "liqprice2",
                                                                  0);
                                                              await UpdateContactDouble(
                                                                  "wallet",
                                                                  wallet +
                                                                      quantity2 *
                                                                          1.007);
                                                              await UpdateContactBoolean(
                                                                  "order2",
                                                                  false);
                                                              order1 = false;
                                                              await UpdateContactString(
                                                                  "entryPrice2",
                                                                  "0");
                                                              entryPrice2 = "0";
                                                              await Getcontact_OnOpen();
                                                              orderitemcount -=
                                                              1;
                                                              setState(() {});
                                                            }catch(e){}
                                                          },
                                                          child: Center(child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: order3,
                                      child: Container(
                                        height: 150,
                                        width: width,
                                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: order2,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(pair3.toUpperCase()+"USDT Perpetual",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),),
                                                Text("$order3time",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text("Limt/"+buyorsell3, style: TextStyle(
                                                    fontSize: 18,
                                                    color: TypeOfColor(longorshort3)),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 15),
                                                CircleAvatar(
                                                  backgroundColor: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  radius: 20,
                                                  child: CircleAvatar(
                                                    backgroundColor: Theme
                                                        .of(context)
                                                        .backgroundColor,
                                                    radius: 16,
                                                    child: Text("0%",
                                                      style: TextStyle(fontSize: 16,
                                                          color: TypeOfColor(longorshort3)),),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Text("Amont \n(USDT)",
                                                  style: TextStyle(fontSize: 15,
                                                      color: Colors.grey),),
                                                SizedBox(width: 30),
                                                Text("$quantity3", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 75),
                                                Text("Price", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),),
                                                SizedBox(width: 37),
                                                Text("$entryPrice3",
                                                  style: TextStyle(fontSize: 16,
                                                      color: Colors.white),),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .end,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty
                                                                .all(Theme
                                                                .of(context)
                                                                .primaryColor),),
                                                          //Theme.of(context).primaryColor
                                                          onPressed: () async {
                                                            try{
                                                            await UpdateContactString(
                                                            "takeProfit3",
                                                            "0");
                                                            await UpdateContactString(
                                                            "stopLoss3",
                                                            "0");
                                                            await UpdateContactDouble(
                                                            "liqprice3",
                                                            0);
                                                            await UpdateContactDouble(
                                                            "wallet",
                                                            wallet+quantity3*1.007);
                                                            await UpdateContactBoolean(
                                                            "order3", false);
                                                            order3=false;
                                                            await UpdateContactString(
                                                            "entryPrice3",
                                                            "0");
                                                            entryPrice3="0";
                                                            await Getcontact_OnOpen();
                                                            orderitemcount-=1;
                                                            setState(() {});
                                                            }catch(e){}
                                                          },
                                                          child: Center(child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: order4,
                                      child: Container(
                                        height: 150,
                                        width: width,
                                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: order3,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(pair4.toUpperCase()+"USDT Perpetual",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),),
                                                Text("$order4time",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text("Limt/"+buyorsell4, style: TextStyle(
                                                    fontSize: 18,
                                                    color: TypeOfColor(longorshort4)),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 15),
                                                CircleAvatar(
                                                  backgroundColor: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  radius: 20,
                                                  child: CircleAvatar(
                                                    backgroundColor: Theme
                                                        .of(context)
                                                        .backgroundColor,
                                                    radius: 16,
                                                    child: Text("0%",
                                                      style: TextStyle(fontSize: 16,
                                                          color: TypeOfColor(longorshort4)),),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Text("Amont \n(USDT)",
                                                  style: TextStyle(fontSize: 15,
                                                      color: Colors.grey),),
                                                SizedBox(width: 30),
                                                Text("$quantity4", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(width: 75),
                                                Text("Price", style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),),
                                                SizedBox(width: 37),
                                                Text("$entryPrice4",
                                                  style: TextStyle(fontSize: 16,
                                                      color: Colors.white),),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .end,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty
                                                                .all(Theme
                                                                .of(context)
                                                                .primaryColor),),
                                                          //Theme.of(context).primaryColor
                                                          onPressed: () async {
                                                            try{
                                                            await UpdateContactString(
                                                            "takeProfit4",
                                                            "0");
                                                            await UpdateContactString(
                                                            "stopLoss4",
                                                            "0");
                                                            await UpdateContactDouble(
                                                            "liqprice4",
                                                            0);
                                                            await UpdateContactDouble(
                                                            "wallet",
                                                            wallet+quantity4*1.007);
                                                            await UpdateContactBoolean(
                                                            "order4", false);
                                                            order4=false;
                                                            await UpdateContactString(
                                                            "entryPrice4",
                                                            "0");
                                                            entryPrice3="0";
                                                            await Getcontact_OnOpen();
                                                            orderitemcount-=1;
                                                            setState(() {});
                                                            }catch(e){}
                                                          },
                                                          child: Center(child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                Column(
                                  children: [
                                    Visibility(
                                      visible:position1,
                                      child: Container(
                                        width: width,
                                        height: 130,
                                        margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "$pair1".toUpperCase() +
                                                              "USDT",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(3)),
                                                            color: TypeOfColor(
                                                                longorshort1),),
                                                          child: Center(
                                                            child: Text(
                                                              "$buyorsell1",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      isolated___cross(typeoftrade1)+"x"+leverage1.toInt().toString(),
                                                      style: TextStyle(fontSize: 12,
                                                          color: Theme.of(context).cardColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 5),

                                                //SizedBox(width: width*0.37),
                                                Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(
                                                        "Unrealized P&L",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(context).cardColor),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        deuxchiffre(double.parse(pnl1)).toString() + '(' +deuxchiffre(double.parse(pnlp1)).toString() +'%)',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: pnlc1,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Margin",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      quantity1.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Entry Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      entryPrice1,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Mark Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$markprice1",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Liq Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      deuxchiffre1(entryPrice1,liqprice1).toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.yellow,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height:8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () => _dialogBuilder(
                                                        context, "takeProfit1",
                                                        "stopLoss1", markprice1,
                                                        longorshort1,text8Controller,text9Controller),
                                                    child: Text("TP/SL"),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () async {
                                                     await closeDialogBox(context,"quantity1","longorshort1","entryPrice1","leverage1","pair1",markprice1,"takeProfit1","stopLoss1","position1","liqprice1");
                                                     Getcontact_OnOpen();
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),

                                    Visibility(
                                      visible:position2,
                                      child: Container(
                                        width: width,
                                        height: 140,
                                        margin: EdgeInsets.fromLTRB(10, 8, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            Visibility(
                                              visible:position1,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "$pair2".toUpperCase() +
                                                              "USDT",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(3)),
                                                            color: TypeOfColor(
                                                                longorshort2),),
                                                          child: Center(
                                                            child: Text(
                                                              "$buyorsell2",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      isolated___cross(typeoftrade2)+"x"+leverage2.toInt().toString(),
                                                      style: TextStyle(fontSize: 12,
                                                          color: Theme.of(context).cardColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 5),

                                                //SizedBox(width: width*0.37),
                                                Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(
                                                        "Unrealized P&L",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:Theme.of(context).cardColor),
                                                      ),
                                                      Text(
                                                        deuxchiffre(double.parse(pnl2)).toString() + '(' +deuxchiffre(double.parse(pnlp2)).toString() +'%)',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: pnlc2,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Margin",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      quantity2.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Entry Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      entryPrice2,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Mark Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$markprice2",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Liq Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      deuxchiffre1(entryPrice2,liqprice2).toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.yellow,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height:8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () => _dialogBuilder(
                                                        context, "takeProfit2",
                                                        "stopLoss2", markprice2,
                                                        longorshort2,text3Controller,text4Controller),
                                                    child: Text("TP/SL"),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () async {
                                                      await closeDialogBox(context,"quantity2","longorshort2","entryPrice2","leverage2","pair2",markprice2,"takeProfit2","stopLoss2","position2","liqprice2");
                                                      Getcontact_OnOpen();
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),

                                    Visibility(
                                      visible:position3,
                                      child: Container(
                                        width: width,
                                        height: 140,
                                        margin: EdgeInsets.fromLTRB(10, 8, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            Visibility(
                                              visible:position2,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "$pair3".toUpperCase() +
                                                              "USDT",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(3)),
                                                            color: TypeOfColor(
                                                                longorshort3),),
                                                          child: Center(
                                                            child: Text(
                                                              "$buyorsell3",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      isolated___cross(typeoftrade3)+"x"+leverage3.toInt().toString(),
                                                      style: TextStyle(fontSize: 12,
                                                          color: Theme.of(context).cardColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 5),

                                                //SizedBox(width: width*0.37),
                                                Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(
                                                        "Unrealized P&L",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(context).cardColor),
                                                      ),
                                                      Text(
                                                        deuxchiffre(double.parse(pnl3)).toString() + '(' +deuxchiffre(double.parse(pnlp3)).toString() +'%)',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: pnlc3,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Margin",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      quantity3.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Entry Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      entryPrice3,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Mark Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$markprice3",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Liq Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      deuxchiffre1(entryPrice3,liqprice3).toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.yellow,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height:8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () => _dialogBuilder(
                                                        context, "takeProfit3",
                                                        "stopLoss3", markprice3,
                                                        longorshort3,text5Controller,text6Controller),
                                                    child: Text("TP/SL"),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () async {
                                                      await closeDialogBox(context,"quantity3","longorshort3","entryPrice3","leverage3","pair3",markprice3,"takeProfit3","stopLoss3","position3","liqprice3");
                                                      Getcontact_OnOpen();
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),
                                    Visibility(
                                      visible:position4,
                                      child: Container(
                                        width: width,
                                        height: 140,
                                        margin: EdgeInsets.fromLTRB(10, 8, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            Visibility(
                                              visible:position3,
                                              child: Divider(color: Theme
                                                  .of(context)
                                                  .cardColor,
                                                  endIndent: width * 0.04,
                                                  indent: width * 0.05,
                                                  thickness: 0.4,
                                                  height: 8),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "$pair4".toUpperCase() +
                                                              "USDT",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(3)),
                                                            color: TypeOfColor(
                                                                longorshort4),),
                                                          child: Center(
                                                            child: Text(
                                                              "$buyorsell4",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      isolated___cross(typeoftrade4)+"x"+leverage4.toInt().toString(),
                                                      style: TextStyle(fontSize: 12,
                                                          color: Theme.of(context).cardColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 5),

                                                //SizedBox(width: width*0.37),
                                                Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(
                                                        "Unrealized P&L",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(context).cardColor),
                                                      ),
                                                      Text(
                                                        deuxchiffre(double.parse(pnl4)).toString() + '(' +deuxchiffre(double.parse(pnlp4)).toString() +'%)',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: pnlc4,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Margin",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      quantity4.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Entry Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      entryPrice4,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Mark Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$markprice4",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Liq Price",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context).cardColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      deuxchiffre1(entryPrice4,liqprice4).toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.yellow,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height:8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () => _dialogBuilder(
                                                        context, "takeProfit4",
                                                        "stopLoss4", markprice4,
                                                        longorshort4,text20Controller,text21Controller),
                                                    child: Text("TP/SL"),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.4,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty
                                                          .all(Color(0xff2b3139)),),
                                                    onPressed: () async {
                                                      await closeDialogBox(context,"quantity4","longorshort4","entryPrice4","leverage4","pair4",markprice4,"takeProfit4","stopLoss4","position4","liqprice4");
                                                      Getcontact_OnOpen();
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),


                  ],

                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<InitializationStatus> _initgooglemobilead(){
    return MobileAds.instance.initialize();
  }
  void _loadRewardedAd(){
    //check_rewardedAd=false;
      RewardedAd.load(adUnitId: "ca-app-pub-6325257519832219/4202269239",
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
              onAdLoaded: (ad) {
                setState((){
                _rewardedAd = ad;
                ad.fullScreenContentCallback = FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (ad) {
                      check_rewardedAd = false;
                      ad.dispose();
                        _loadRewardedAd();
                    },
                );
                check_rewardedAd = true;
                });
              },
              onAdFailedToLoad: (erreur) {
                print("fail to load RewardedAd");
              }
          )
      );
  }
  /*void showRewardedAd(){
    check1_rewardedAd=false;
      _rewardedAd.show(onUserEarnedReward: (AdWithoutView ad,RewardItem item){
        print("11111111111111111111111111");
     setState(() {
       check1_rewardedAd=true;
     });
    });
  }*/
  run_streamListener()async{
    for(int i=1;i<5;i++) {
      streamListener();
      await Future.delayed(Duration(seconds: 1));
      i-=1;
      i=i+stop_test;
    }
  }
  streamListener() async {
    var channel = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/' + selctedcrypto+ 'usdt@aggTrade');
    try {
      channel.stream.listen((message) {
        // channel.sink.add('received!');
        // channel.sink.close(status.goingAway);
        Map getData = jsonDecode(message);
          btcUsdtPrice = getData['p'];

      });
      setState((){});
      channel.sink.close();
    }catch(e){}
  }


  streamListener4(String pair) {
    var channel4 = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/'+pair+'usdt@aggTrade');
    channel4.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice4 = getData['p'];
      });
      // print(getData['p']);
    });
    channel4.sink.close();
  }



  streamListener1(String pair) {
    var channel1 = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/' + pair + 'usdt@aggTrade');
    channel1.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice1 = getData['p'];
      });
      // print(getData['p']);
    });
    channel1.sink.close();
  }

  streamListener2(String pair) {
    var channel2 = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/' + pair + 'usdt@aggTrade');
    channel2.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice2 = getData['p'];
      });
      // print(getData['p']);
    });
    channel2.sink.close();
  }

  streamListener3(String pair) {
    var channel3 = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/' + pair + 'usdt@aggTrade');
    channel3.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice3 = getData['p'];
      });
      // print(getData['p']);
    });
    channel3.sink.close();
  }


  Future Getcontact_OnOpen() async {
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
      check_int=200;
      print("Getcontact_OnOpen");
      //print(res.body);
      var jsonData = json.decode(res.body);
      stopLoss1 = jsonData["stopLoss1"];
      stopLoss2 = jsonData["stopLoss2"];
      stopLoss3 = jsonData["stopLoss3"];
      stopLoss4 = jsonData["stopLoss4"];
      liqprice1 = jsonData["liqprice1"];
      liqprice2 = jsonData["liqprice2"];
      liqprice3 = jsonData["liqprice3"];
      liqprice4 = jsonData["liqprice4"];
      quantity1 = jsonData["quantity1"];
      quantity2 = jsonData["quantity2"];
      quantity3 = jsonData["quantity3"];
      quantity4 = jsonData["quantity4"];
      longorshort1 = jsonData["longorshort1"];
      longorshort2 = jsonData["longorshort2"];
      longorshort3 = jsonData["longorshort3"];
      longorshort4 = jsonData["longorshort4"];
      takeProfit1 = jsonData["takeProfit1"];
      takeProfit2 = jsonData["takeProfit2"];
      takeProfit3 = jsonData["takeProfit3"];
      takeProfit4 = jsonData["takeProfit4"];
      entryPrice1 = jsonData["entryPrice1"];
      entryPrice2 = jsonData["entryPrice2"];
      entryPrice3 = jsonData["entryPrice3"];
      entryPrice4 = jsonData["entryPrice4"];
      wallet = jsonData["wallet"];
      leverage1 = jsonData["leverage1"];
      leverage2 = jsonData["leverage2"];
      leverage3 = jsonData["leverage3"];
      leverage4 = jsonData["leverage4"];
      pair1 = jsonData["pair1"];
      pair2 = jsonData["pair2"];
      pair3 = jsonData["pair3"];
      pair4 = jsonData["pair4"];
      order1 = jsonData["order1"];
      order2 = jsonData["order2"];
      order3 = jsonData["order3"];
      order4 = jsonData["order4"];
      order1time = jsonData["order1time"];
      order2time = jsonData["order2time"];
      order3time = jsonData["order3time"];
      order4time = jsonData["order4time"];
      position1 = jsonData["position1"];
      position2 = jsonData["position2"];
      position3 = jsonData["position3"];
      position4 = jsonData["position4"];
      typeoftrade1 = jsonData["typeoftrade1"];
      typeoftrade2 = jsonData["typeoftrade2"];
      typeoftrade3 = jsonData["typeoftrade3"];
      typeoftrade4 = jsonData["typeoftrade4"];
    }
    else{
      check_int=0;
    }
  } catch (e) {
      print("Getcontact_OnOpen erreur");
      Future(() {
        hasNetwork();
        getData();
      });
    }
  }



  Future Getcontact() async {
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
      check_int=200;
      var jsonData = json.decode(res.body);
      wallet = jsonData["wallet"];
      position1 = jsonData["position1"];
      position2 = jsonData["position2"];
      position3 = jsonData["position3"];
      position4 = jsonData["position4"];
      //setState((){});
    }
    else{
      check_int=0;
    }
    } catch (e) {
      print("Getcontact erreur");
      Future(() {
        hasNetwork();
        getData();
      });
    }
  }

  Future TypeOfTrade() async {
    if (longorshort1 == true) {
      buyorsell1 = "Long";
    }
    else if (longorshort1 == false) {
      buyorsell1 = "Short";
    }
    if (longorshort2 == true) {
      buyorsell2 = "Long";
    }
    else if (longorshort2 == false) {
      buyorsell2 = "Short";
    }
    if (longorshort3 == true) {
      buyorsell3 = "Long";
    }
    else if (longorshort3 == false) {
      buyorsell3 = "Short";
    }
    if (longorshort4 == true) {
      buyorsell4 = "Long";
    }
    else if (longorshort4 == false) {
      buyorsell4 = "Short";
    }
  }

  TypeOfColor(bool x) {
    if (x == true) {
      return Colors.green;
    }
    else if (x == false) {
      return Colors.red;
    }
  }
  bool check_entryprice(bool x){
    if (x==true){
      if(double.parse(btcUsdtPrice)>double.parse(text7Controller.text)){
        return true;
      }
      else {return false;}
    }
    else{
      if(double.parse(btcUsdtPrice)<double.parse(text7Controller.text)){
        return true;
      }
      else {return false;}
    }
  }

  Future UpdateContactBoolean(String parametre, bool bool) async {
    String url = "http://" + api +
        ":8011/contacts/wallet/$contact_id";
    var res = await http.put(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({parametre: bool}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updatedd");
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

  double deuxchiffre1(String entryprice,double x){
    try {
      String y = x.toString();
      int z = entryprice.length;
      y = y.substring(0, z + 1);
      return double.parse(y);
    }catch(e){
      return 0.0;
    }
  }

  bool isolated__cross(String isolatedcross){
    if(isolatedcross=="Isolated"){return true;}
    else{return false;}
  }
  String isolated___cross(bool x){
    if(x==true){return "Isolated ";}
    else{return "Cross ";}
  }

  Future<void> buy_sell1(bool x) async {
    if(sizeusdt>=1 && btcUsdtPrice!="0") {
      if (order1 == false && position1 == false) {
        print(btcUsdtPrice);
        await UpdateContactString(
            "entryPrice1",
            btcUsdtPrice);
        await UpdateContactString(
            "pair1", selctedcrypto);
        await UpdateContactDouble(
            "leverage1", leverage);
        await UpdateContactBoolean(
            "longorshort1", x);
        await UpdateContactDouble(
            "quantity1", deuxchiffre((wallet * sizeusdt / 100) * 0.99));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade1", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit1", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
             await UpdateContactString(
                "stopLoss1", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "position1", true);
        await Getcontact_OnOpen();
        liqprice1 = liquidation_price(
            longorshort1,
            isolated__cross(isolated_cross),
            double.parse(entryPrice1),
            selectedmaxleverage,
            leverage1,
            wallet,
            quantity1);
      }
      else if (order2 == false && position2 == false) {
        await UpdateContactString(
            "entryPrice2",
            btcUsdtPrice);
        await UpdateContactString(
            "pair2", selctedcrypto);
        await UpdateContactDouble(
            "leverage2", leverage);
        await UpdateContactBoolean(
            "longorshort2", x);
        await UpdateContactDouble(
            "quantity2", deuxchiffre((wallet * sizeusdt / 100) * 0.99));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade2", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit2", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss2", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "position2", true);
        await Getcontact_OnOpen();
        liqprice2 = liquidation_price(
            longorshort2,
            isolated__cross(isolated_cross),
            double.parse(entryPrice2),
            selectedmaxleverage,
            leverage2,
            wallet,
            quantity2);
      }
      else if (order3 == false && position3 == false) {
        await UpdateContactString(
            "entryPrice3",
            btcUsdtPrice);
        await UpdateContactString(
            "pair3", selctedcrypto);
        await UpdateContactDouble(
            "leverage3", leverage);
        await UpdateContactBoolean(
            "longorshort3", x);
        await UpdateContactDouble(
            "quantity3", deuxchiffre((wallet * sizeusdt / 100) * 0.99));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade3", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit3", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss3", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "position3", true);
        await Getcontact_OnOpen();
        liqprice3 = liquidation_price(
            longorshort3,
            isolated__cross(isolated_cross),
            double.parse(entryPrice3),
            selectedmaxleverage,
            leverage3,
            wallet,
            quantity3);
      }
      else if (order4 == false && position4 == false) {
        await UpdateContactString(
            "entryPrice4",
            btcUsdtPrice);
        await UpdateContactString(
            "pair4", selctedcrypto);
        await UpdateContactDouble(
            "leverage4", leverage);
        await UpdateContactBoolean(
            "longorshort4", x);
        await UpdateContactDouble(
            "quantity4", deuxchiffre((wallet * sizeusdt / 100) * 0.99));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade4", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit4", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss4", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "position4", true);
        await Getcontact_OnOpen();
        liqprice4 = liquidation_price(
            longorshort4,
            isolated__cross(isolated_cross),
            double.parse(entryPrice4),
            selectedmaxleverage,
            leverage4,
            wallet,
            quantity4);
      }
      else{Check_nb_Position(context);}
      setState((){});
    }
    else{
      print("empty size");
      CheckSize(context);
    }
  }

  Future<void> buy_sell(bool x) async {

      if (order1 == false && position1 == false) {
        order1time = await DateFormat(
            'yyyy-mm-dd hh:mm:ss').format(
            DateTime.now());
        print(order1time);
        await UpdateContactString(
            "order1time",
            order1time);
        await UpdateContactString(
            "entryPrice1",
            text7Controller.text);
        await UpdateContactString(
            "pair1", selctedcrypto);
        await UpdateContactDouble(
            "leverage1", leverage);
        await UpdateContactBoolean(
            "longorshort1", x);
        await UpdateContactDouble(
            "quantity1", deuxchiffre((wallet * sizeusdt / 100) * 0.995));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade1", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit1", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss1", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "order1", true);
        await Getcontact_OnOpen();
        liqprice1 = liquidation_price(
            longorshort1,
            isolated__cross(isolated_cross),
            double.parse(entryPrice1),
            selectedmaxleverage,
            leverage1,
            wallet,
            quantity1);
      }
      else if (order2 == false && position2 == false) {
        order2time = DateFormat(
            'yyyy-mm-dd hh:mm:ss').format(
            DateTime.now());
        await UpdateContactString(
            "order2time",
            order2time);
        await UpdateContactString(
            "entryPrice2",
            text7Controller.text);
        await UpdateContactString(
            "pair2", selctedcrypto);
        await UpdateContactDouble(
            "leverage2", leverage);
        await UpdateContactBoolean(
            "longorshort2", x);
        await UpdateContactDouble(
            "quantity2", deuxchiffre((wallet * sizeusdt / 100) * 0.995));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade2", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit2", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss2", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "order2", true);
        await Getcontact_OnOpen();
        liqprice2 = liquidation_price(
            longorshort2,
            isolated__cross(isolated_cross),
            double.parse(entryPrice2),
            selectedmaxleverage,
            leverage2,
            wallet,
            quantity2);
      }
      else if (order3 == false && position3 == false) {
        order3time = DateFormat(
            'yyyy-mm-dd hh:mm:ss').format(
            DateTime.now());
        await UpdateContactString(
            "order3time",
            order3time);
        await UpdateContactString(
            "entryPrice3",
            text7Controller.text);
        await UpdateContactString(
            "pair3", selctedcrypto);
        await UpdateContactDouble(
            "leverage3", leverage);
        await UpdateContactBoolean(
            "longorshort3", x);
        await UpdateContactDouble(
            "quantity3", deuxchiffre((wallet * sizeusdt / 100) * 0.995));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade3", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit3", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss3", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "order3", true);
        await Getcontact_OnOpen();
        liqprice3 = liquidation_price(
            longorshort3,
            isolated__cross(isolated_cross),
            double.parse(entryPrice3),
            selectedmaxleverage,
            leverage3,
            wallet,
            quantity3);
      }
      else if (order4 == false && position4 == false) {
        order4time = DateFormat(
            'yyyy-mm-dd hh:mm:ss').format(
            DateTime.now());
        await UpdateContactString(
            "order4time",
            order4time);
        await UpdateContactString(
            "entryPrice4",
            text7Controller.text);
        await UpdateContactString(
            "pair4", selctedcrypto);
        await UpdateContactDouble(
            "leverage4", leverage);
        await UpdateContactBoolean(
            "longorshort4", x);
        await UpdateContactDouble(
            "quantity4", deuxchiffre((wallet * sizeusdt / 100) * 0.995));
        await UpdateContactDouble(
            "wallet", deuxchiffre(wallet - (wallet * sizeusdt / 100)));
        await UpdateContactBoolean(
            "typeoftrade4", isolated__cross(isolated_cross));
        if (TPSLcheckbox == true) {
          if(text11Controller.text.length>0) {
            await UpdateContactString(
                "takeProfit4", text11Controller.text);
          }
          if(text12Controller.text.length>0) {
            await UpdateContactString(
                "stopLoss4", text12Controller.text);
          }
        }
        await UpdateContactBoolean(
            "order4", true);
        await Getcontact_OnOpen();
        liqprice4 = liquidation_price(
            longorshort4,
            isolated__cross(isolated_cross),
            double.parse(entryPrice4),
            selectedmaxleverage,
            leverage4,
            wallet,
            quantity4);
      }
      else{Check_nb_Position(context);}
      setState(() {});

  }

  void checkorder(){
    orderitemcount=0;
    if(order1==true){orderitemcount+=1;}
    if(order2==true){orderitemcount+=1;}
    if(order3==true){orderitemcount+=1;}
    if(order4==true){orderitemcount+=1;}
  }
  void checkposition(){
    positionitemcount=0;
    if(position1==true){positionitemcount+=1;}
    if(position2==true){positionitemcount+=1;}
    if(position3==true){positionitemcount+=1;}
    if(position4==true){positionitemcount+=1;}
  }

  Future<void> _dialogBuilder(BuildContext context,String x,String y,String markprice00,bool typeoftrde0,final text1Controller,final text2Controller) async {
    await Getcontact_OnOpen();
    String hh ="$x".substring(10);
    String profit="";
    String lose="";
    String entry_price="";
    double leverage_=0.0;
    double margin_=0.0;

    if(hh.contains("1")==true){
      profit=takeProfit1;
      lose=stopLoss1;
      entry_price=entryPrice1;
      leverage_=leverage1;
      margin_=quantity1;
    }
    else if(hh.contains("2")==true){
      profit=takeProfit2;
      lose=stopLoss2;
      entry_price=entryPrice2;
      leverage_=leverage2;
      margin_=quantity2;
    }
    else if(hh.contains("3")==true){
      profit=takeProfit3;
      lose=stopLoss3;
      entry_price=entryPrice3;
      leverage_=leverage3;
      margin_=quantity3;
    }
    else if(hh.contains("4")==true){
      profit=takeProfit4;
      lose=stopLoss4;
      entry_price=entryPrice4;
      leverage_=leverage4;
      margin_=quantity4;
    }
    if(profit=="0"){profit="";}
    if(lose=="0"){lose="";}
    text1Controller.text=profit;
    text2Controller.text=lose;

    String calcul_pnl(String tpsl){
      if(tpsl!="") {
        double x = deuxchiffre(margin_*unrealizedpnl(entry_price, tpsl, typeoftrde0,
            leverage_, true));
        return x.toString();
      }
      else {
        return "";
      }
    }
    String ss=calcul_pnl(profit);
    String ff=calcul_pnl(lose);
    String l1="0";
    String l2="0";
    bool visibiltiy1=false;
    bool visibiltiy2=false;
    if(ss==""){l1="0";visibiltiy1=false;}
    else{l1=ss;visibiltiy1=true;}
    if(ff==""){l2="0";visibiltiy2=false;}
    else{l2=ff;visibiltiy2=true;}
    Color profit_color=unrealizedpnl_color(double.parse(l1));
    Color loss_color=unrealizedpnl_color(double.parse(l2));;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context)  {

        var size = MediaQuery.of(context).size;
        var height = size.height;
        var width = size.width;
        return AlertDialog(

          buttonPadding:EdgeInsets.zero ,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: width*0.8,
              height: 270,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TP/SL",
                        style: TextStyle(color: Colors.white,fontSize: 18 ),
                      ),
                      IconButton(
                          onPressed: (){Navigator.pop(context);},
                          icon:Icon(Icons.close,color: Theme.of(context).cardColor,size: 20,) ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Take profit",
                    style: TextStyle(color: Colors.white,fontSize: 15 ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:5),
                    width: width*0.75,
                    height: 40,
                    decoration:BoxDecoration(
                      color:Color(0xff2b3139),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      onChanged: (e){
                        ss=calcul_pnl(e);
                        profit_color=unrealizedpnl_color(double.parse(ss));
                      },
                      style: const TextStyle(color: Colors.white),
                      controller: text1Controller,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(ss,style: TextStyle(color:profit_color,fontSize: 14),),
                                  Visibility(visible: visibiltiy1,child: Text(" USDT",style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),)),
                                  SizedBox(width:3),
                                  Visibility(
                                    visible: visibiltiy1,
                                    child: InkWell(
                                        onTap:()async{
                                         await UpdateContactString("$x","0");
                                         ss="";
                                         Navigator.pop(context);
                                        } ,
                                        child:  Text(
                                          "Cancel",
                                          style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12,decoration: TextDecoration.underline)
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        hintText: profit,
                        hintStyle: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),
                        border: InputBorder.none,
                      ) ,
                      cursorColor: Color(0xff246EE9),
                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Stop Loss",
                    style: TextStyle(color:Colors.white,fontSize: 15 ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:5),
                    width: width*0.75,
                    height: 40,
                    decoration:BoxDecoration(
                      color:Color(0xff2b3139),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      onChanged: (e){
                        ff=calcul_pnl(e);
                        loss_color=unrealizedpnl_color(double.parse(ff));
                      },
                      style: const TextStyle(color: Colors.white),
                      controller: text2Controller,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(ff,style: TextStyle(color:loss_color,fontSize: 14),),
                                  Visibility(visible: visibiltiy2,child: Text(" USDT",style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),)),
                                  SizedBox(width:3),
                                  Visibility(
                                    visible: visibiltiy2,
                                    child: InkWell(
                                      onTap:()async{
                                        await UpdateContactString("$y","0");
                                        ff="";
                                        Navigator.pop(context);
                                      } ,
                                      child: Text(
                                          "Cancel",
                                          style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12,decoration: TextDecoration.underline)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        hintText: lose,
                        hintStyle: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),
                        border: InputBorder.none,
                      ) ,
                      cursorColor: Color(0xff246EE9),
                      keyboardType:TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,6}'))
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 100,
                    height: 15,
                    child: Visibility(
                      visible: TPSLerreur,
                      child: Text(
                        " erreur",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: width*0.3,
                      height: height*0.05,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(5),color: Color(0xff246EE9)),
                      child: TextButton(
                        onPressed: () async{
                          try{
                          _rewardedAd.show(onUserEarnedReward: (AdWithoutView ad,RewardItem item) async {
                            //_loadRewardedAd();
                            run_rewardedAd=0;
                            update_user();
                            int BB=0;
                            int AA=0;
                            if(text1Controller.text.isEmpty ==false){
                              AA+=1;
                              if(check_tp_and_sl(text1Controller.text, typeoftrde0, markprice00)==true){
                                AA+=1;
                              }
                            }
                            if(text2Controller.text.isEmpty ==false){
                              BB+=1;
                              if(check_tp_and_sl(text2Controller.text, !typeoftrde0, markprice00)==true){
                                BB+=1;
                              }
                            }
                            if(BB==2&&AA==2 || BB==2&&AA==0 || BB==0&&AA==2 ){
                              TPSLerreur=false;
                              if(AA==2){
                                await UpdateContactString("$x",text1Controller.text);
                                x=text1Controller.text;
                              }
                              if(BB==2) {
                                await UpdateContactString("$y", text2Controller.text);
                                y=text2Controller.text;
                              }
                              Navigator.pop(context);
                            }
                            else {
                              if(text2Controller.text.isEmpty ==false || text1Controller.text.isEmpty ==false) {
                                TPSLerreur = true;
                              }
                            }
                          });
                          }catch(e){
                            int BB=0;
                            int AA=0;
                            if(text1Controller.text.isEmpty ==false){
                              AA+=1;
                              if(check_tp_and_sl(text1Controller.text, typeoftrde0, markprice00)==true){
                                AA+=1;
                              }
                            }
                            if(text2Controller.text.isEmpty ==false){
                              BB+=1;
                              if(check_tp_and_sl(text2Controller.text, !typeoftrde0, markprice00)==true){
                                BB+=1;
                              }
                            }
                            if(BB==2&&AA==2 || BB==2&&AA==0 || BB==0&&AA==2 ){
                              TPSLerreur=false;
                              if(AA==2){
                                await UpdateContactString("$x",text1Controller.text);
                                x=text1Controller.text;
                              }
                              if(BB==2) {
                                await UpdateContactString("$y", text2Controller.text);
                                y=text2Controller.text;
                              }
                              Navigator.pop(context);
                            }
                            else {
                              if(text2Controller.text.isEmpty ==false || text1Controller.text.isEmpty ==false) {
                                TPSLerreur = true;
                              }
                            }
                            //_loadRewardedAd();
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> check_internet(BuildContext context) async {
    check_int_isopen=true;
     showDialog<void>(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: width*2,
            height:height*2,
            child: AlertDialog(
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
                    ],
                  );
                },
              ),
            ),
          );
        }
    );
    for (int i = 1; i < 3; i++) {
      await Future.delayed(Duration(seconds:3));
      print("close check internet1111");
      hasNetwork();
      if(l==true ) {
        print("close check internet");
        check_int_isopen=false;
        Navigator.pop(context);
        i=i+4;
      }
      else {
        i = i - 1;
      }
    }
  }



  bool ?check_tp_and_sl(String takeprofit,bool typeoftrde,String markprice0){
    if(typeoftrde==true){
      if(double.parse('$takeprofit')>double.parse('$markprice0')&&double.parse('$takeprofit')>0 && double.parse('$markprice0')>0){return true;}
      else {return false;}
    }
    else if(typeoftrde==false){
      if(double.parse('$takeprofit')<double.parse('$markprice0')&&double.parse('$takeprofit')>0 && double.parse('$markprice0')>0){return true;}
      else {return false;}
    }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    test();
    run_streamListener();
    super.initState();
  }
  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    Disconnect();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      await Disconnect();
    };
    if (state == AppLifecycleState.resumed) {
      await Connect();
    };


    }

  void getData() async {
    if(l==false && check_int_isopen==false) {
        print("check internet");
        check_int_isopen=true;
        check_internet(context);
    }
  }
  bool l=false;
  Future<void> hasNetwork() async {
    String url = "http://" +api+
        ":8011/actuator";
    try {
      var res = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        l=true;
      }

    }catch(e){
     l=false;
    }
  }

  int calculhours(){
    int x =dateTime.hour-date11;
    if(x>=8)
      {x=x-8;}
    if(x>=8)
    {x=x-8;}
    x=8-x-1;
    return x;
  }
  local_storage()async{
    token = await storage.read(key: "token");
    contact_id = await storage.read(key: "contact_id");
    user_id = await storage.read(key: "user_id");
    String? fff=await storage.read(key: "leverage");
    _Value=leverage= double.parse(fff.toString());
    String? kkk = await storage.read(key: "pair");
    String? jjj = await storage.read(key: "selectedmaxleverage");
    selctedcrypto = kkk.toString();
    selectedmaxleverage=int.parse(jjj.toString());
    selectedmaxleverage2 = selectedmaxleverage * 0.2;
    selectedmaxleverage4 = selectedmaxleverage * 0.4;
    selectedmaxleverage6 = selectedmaxleverage * 0.6;
    selectedmaxleverage8 = selectedmaxleverage * 0.8;
  }


void test() async {
    //await check_token();
    await local_storage();
    WidgetsFlutterBinding.ensureInitialized();
    //MobileAds.instance.initialize();
    //_initgooglemobilead();
      //_loadRewardedAd();
    _controller.start();
    date11 = int.parse(dateTime.timeZoneOffset.inHours.toString());
    await Connect();
      await Getcontact_OnOpen();
    FlutterNativeSplash.remove();
    for (int i = 1; i < 5; i++) {
      try{
      checkorder();
      Future(() {
        hasNetwork();
        getData();
      });
        if(position1==true||position2==true||position3==true||position4==true||order1==true||order2==true||order3==true||order4==true) {
          await Getcontact();
        }
        checkposition();
      //streamListener4();
      TypeOfTrade();
      //if(position1 == false){positionitemcount=0;}
      if (position1 == true) {
        order1=false;
        streamListener1(pair1);
        pnl1 = (unrealizedpnl(
            entryPrice1, markprice1, longorshort1, leverage1, position1) *
            quantity1).toString();
        pnlp1 = (unrealizedpnl(
            entryPrice1, markprice1, longorshort1, leverage1, position1) * 100)
            .toString();
        pnlc1 = unrealizedpnl_color(unrealizedpnl(
            entryPrice1, markprice1, longorshort1, leverage1, position1) *
            quantity1);
        // deuxchiffre((unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2)).toString()+"("+deuxchiffre((unrealizedpnl("16000", markprice2, longorshort2, leverage2,position2)*100)).toString()+"%)"

      }
      if (position2 == true) {
        order2=false;
        streamListener2(pair2);
        pnl2 = (unrealizedpnl(
            entryPrice2, markprice2, longorshort2, leverage2, position2) *
            quantity2).toString();
        pnlp2 = (unrealizedpnl(
            entryPrice2, markprice2, longorshort2, leverage2, position2) * 100)
            .toString();
        pnlc2 = unrealizedpnl_color(unrealizedpnl(
            entryPrice2, markprice2, longorshort2, leverage2, position2) *
            quantity2);
      }
      if (position3 == true) {
        order3=false;
        streamListener3(pair3);
        pnl3 = (unrealizedpnl(
            entryPrice3, markprice3, longorshort3, leverage3, position3) *
            quantity3).toString();
        pnlp3 = (unrealizedpnl(
            entryPrice3, markprice3, longorshort3, leverage3, position3) * 100)
            .toString();
        pnlc3 = unrealizedpnl_color(unrealizedpnl(
            entryPrice3, markprice3, longorshort3, leverage3, position3) *
            quantity3);
      }
        if (position4 == true) {
          order4=false;
          streamListener4(pair4);
          pnl4 = (unrealizedpnl(
              entryPrice4, markprice4, longorshort4, leverage4, position4) *
              quantity4).toString();
          pnlp4 = (unrealizedpnl(
              entryPrice4, markprice4, longorshort4, leverage4, position4) * 100)
              .toString();
          pnlc4 = unrealizedpnl_color(unrealizedpnl(
              entryPrice4, markprice4, longorshort4, leverage4, position4) *
              quantity4);
        }

    } catch (e) {
      print("all erreur");
    }
   try{
      if(run_rewardedAd>=151){
        //if(run_rewardedAd==3000){
        _rewardedAd.show(onUserEarnedReward: (AdWithoutView ad,RewardItem item) {
          update_user();
          //_loadRewardedAd();
        });
        run_rewardedAd=0;
      }
      else{run_rewardedAd+=1;}
    }catch(e){}
      await Future.delayed(Duration(seconds:2));
      i=i+stop_test;
      i = i - 1;
    }
  }
}










