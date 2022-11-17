


import 'dart:async';
import 'package:cryptoo/screens/signin.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import 'Cryptolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff474d57),
        backgroundColor:  Color(0xff171e26),
        cardColor: Color(0xffb7bdc6),
        buttonColor: Color(0xfff0b90b),
        canvasColor: Color(0xff1f2630)
      ),
      home:  SignInScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  String btcUsdtPrice = "0";
  String ethUsdtPrice = "0";





  static List<Cryptolistusdt> Cryptolist =[
    Cryptolistusdt("btc",1,125,"btc"),
    Cryptolistusdt("eth",2,100,"eth"),
    Cryptolistusdt("bnb",3,125,"bnb"),
    Cryptolistusdt("btc",4,25,"btc"),
  ];

  List<Cryptolistusdt> display_list = List.from(Cryptolist);

void Updatelist(String value){
  setState((){
    display_list = Cryptolist.where((element) => element.movie_title!.toLowerCase().contains(value.toLowerCase())).toList();
  });
}

  String api = "192.168.1.105";

  String buyorsell1 = "Long";
  String buyorsell2 = "Long";
  String buyorsell3 = "Long";

  String markprice1="0";
  String markprice2="0";
  String markprice3="0";
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
  double wallet = 100.0;
  double leverage1 = 10.0;
  double leverage2 = 10.0;
  double leverage3 = 10.0;
  String pair1="btc";
  String pair2="btc";
  String pair3="btc";
  bool position1 = false;
  bool position2 = false;
  bool position3 = false;
  bool order1 = false;
  bool order2 = false;
  bool order3 = false;
  String stopLoss2="0";
  String stopLoss3="0";
  String stopLoss1="0";
  String takeProfit1 = "0";
  String takeProfit2 = "0";
  String takeProfit3 = "0";

  String pnlp1 ="0";
  String pnl1 = "0";
  String pnlp2 ="0";
  String pnl2 = "0";
  String pnlp3 ="0";
  String pnl3 = "0";
  Color pnlc1= Colors.white;
  Color pnlc2= Colors.white;
  Color pnlc3= Colors.white;




  var price = 0.0;
  var name = 'Coin Name';
  var symbol = 'Symbol';
  var size,height,width;
  var typeoftrade = "Isolated";
  double _Value = 25;
  double leverage=25 ;
  String selctedcrypto = "btc";
  int selectedmaxleverage = 125 ;
  double selectedmaxleverage2 = 25;
  double selectedmaxleverage4 = 50;
  double selectedmaxleverage6 = 75;
  double selectedmaxleverage8 = 100;
  bool TPSLcheckbox = false;
  bool Reduceonlycheckbox = false;
  int orderitemcount=0;
  String order1pairs = "btc";
  String order2pairs = "btc";
  String order3pairs = "btc";
  bool order1visibility = false;
  bool order2visibility = false;
  bool order3visibility = false;
  String order1price = "0" ;
  String order2price = "0" ;
  String order3price = "0" ;
  String order1time = "ffff";
  String order2time = "ffff";
  String order3time = "ffff";

  late TabController _tabController = TabController(length: 3, vsync: this );
  late TabController _tabController2 = TabController(length: 2, vsync: this );
  final text1Controller = TextEditingController();
  final text2Controller = TextEditingController();
  final text3Controller = TextEditingController();
  final text4Controller = TextEditingController();
  final text5Controller = TextEditingController();
  final text6Controller = TextEditingController();
  final text7Controller = TextEditingController();

  String sizecurency = "USDT";
  final GlobalKey<ScaffoldState> _key = GlobalKey();



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            width: width*0.6,
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Derivatives",style: TextStyle(fontSize: 24,color: Colors.white),),

                Container(
                  height: 35,
                  margin: EdgeInsets.fromLTRB(0, 15, 10, 0),
                  child: TextField(
                    onChanged:(value) => Updatelist(value) ,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search,color:Colors.white38 ,),
                      hintText: "search",
                      hintStyle:TextStyle(color: Colors.white38,height: 2.5 )  ,
                    ),
                  ),

                ),
                SizedBox(height: 20,),
                Expanded(child: ListView.builder(
                  itemCount: display_list.length,
                    itemBuilder: (context,index)=> MaterialButton(onPressed: (){
                      selctedcrypto = display_list[index].movie_title! ;
                      selectedmaxleverage = display_list[index].rating! ;
                      selectedmaxleverage2 = selectedmaxleverage*0.2;
                      selectedmaxleverage4 = selectedmaxleverage*0.4;
                      selectedmaxleverage6 = selectedmaxleverage*0.6;
                      selectedmaxleverage8 = selectedmaxleverage*0.8;
                      leverage=25;
                      setState((){});
                      Navigator.of(context).pop();

                    },
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(display_list[index].movie_title!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),

                        contentPadding: EdgeInsets.fromLTRB(10,0,15,0),
                        trailing: Text("${display_list[index].rating}",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                    ),
                ),
                ),
              ],

            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Container(


          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                     children: [
                       Builder(builder: (context) =>
                       InkWell(
                           child: Row(
                             children: [
                               SizedBox(width: 3),
                               Icon(Icons.menu_open_sharp,size: 35,color: Colors.white,),
                               SizedBox(width: 5,),
                               Text("$selctedcrypto",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                             ],
                           ),
                           onTap: () => Scaffold.of(context).openDrawer()
                       ),
                       ),
                     ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 43),
                        Text(btcUsdtPrice,style: TextStyle(color: Theme.of(context).cardColor,fontSize: 13),),
                        SizedBox(width: 43),
                        Text(markprice1,style: TextStyle(color: Theme.of(context).cardColor,fontSize: 13),),
                      ],
                    ),
                    SizedBox(height: 3,),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start ,
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),color: Theme.of(context).canvasColor,),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                 height: 30,
                                width: width*0.22,
                                color:  Theme.of(context).primaryColor,
                                child: DropdownButton(

                                  elevation: 0,
                                  icon: Icon(Icons.arrow_drop_down,size: 20,color: Colors.white,),
                                  underline: Container(),
                                  items: ["Isolated","Cross"].map((e) =>
                                      DropdownMenuItem(
                                        child:  Text("$e",style: TextStyle(color: Colors.white,backgroundColor:  Color(0xff474d57),fontSize: 15),),
                                        value: e,
                                        alignment: Alignment.center,
                                      )
                                  ).toList(), onChanged: (String? val){
                                  setState(() {
                                    typeoftrade = val! ;

                                  });
                                }, value: typeoftrade,
                                  dropdownColor:  Color(0xff474d57),
                                  isExpanded: true,
                                ),
                              ),


                              MaterialButton(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: width*0.14,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(leverage.round().toString(),style: TextStyle(color: Colors.white),),
                                      Icon(Icons.arrow_drop_down,size: 20,color: Colors.white,),
                                    ],
                                  ),
                                ),
                                onPressed: (){
                                  _Value=leverage;
                                  showModalBottomSheet(context: context, builder: (BuildContext context){
                                    return StatefulBuilder(
                                      builder: (BuildContext context, State){
                                        return Container(
                                          decoration: BoxDecoration(color: Theme.of(context).backgroundColor,borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20))  , ),
                                          height: height*0.5,
                                          width: width,
                                          child: SingleChildScrollView(
                                            child: Column(

                                              children: [
                                                SizedBox(height: 5,),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                    children: [
                                                      SizedBox(width: 35,),
                                                      Text('Adjuste Leverage',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ),

                                                      IconButton(icon: Icon(Icons.close,size: 25,color: Theme.of(context).cardColor,) ,onPressed: (){
                                                        Navigator.pop(context);
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(10,5,10,5) ,
                                                  color: Theme.of(context).primaryColor,
                                                  height: 40,

                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      IconButton(onPressed: (){
                                                        _Value -= 1 ;
                                                        State(() {});
                                                        setState(() {});
                                                      },
                                                        icon: Icon(Icons.remove,color: Theme.of(context).cardColor,),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(_Value.round().toString() ,
                                                            style: TextStyle(fontSize: 17,color: Colors.white),
                                                          ),
                                                          SizedBox(width: 1,),
                                                          Text("x",style: TextStyle(fontSize: 17,color: Colors.white),)
                                                        ],
                                                      ),
                                                      IconButton(onPressed: (){
                                                        if (_Value<124){

                                                          setState(() { _Value += 1 ; });
                                                          State(() {});
                                                        };
                                                      },
                                                        icon: Icon(Icons.add,color: Theme.of(context).cardColor,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(10,7,10,10),
                                                  width: width*0.95,
                                                  child: StatefulBuilder(builder: (context, set) {
                                                    return  Stack(
                                                      children:[

                                                        Container(
                                                          width: width*0.95,
                                                          child: SliderTheme(
                                                            data: SliderThemeData(
                                                              inactiveTickMarkColor: Colors.blue,
                                                              activeTickMarkColor: Colors.red,
                                                              trackHeight: 3,
                                                            ),
                                                            child: Slider(
                                                              autofocus: true,
                                                              value: _Value,
                                                              label: _Value.round().toString(),
                                                              activeColor: Colors.grey[600],
                                                              min: 1,
                                                              max: selectedmaxleverage.toDouble(),
                                                              divisions: selectedmaxleverage-1,
                                                              onChanged: (double e){
                                                                _Value= e;
                                                                set(() {
                                                                });
                                                                State(() {});
                                                              },

                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            IconButton(onPressed: (){State((){});_Value=1;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,),),
                                                            Text(" 1x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                          ],
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(width*0.16, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                IconButton(onPressed: (){State((){});_Value=selectedmaxleverage*0.2;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                                Text(selectedmaxleverage2.round().toString()+"x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                              ],
                                                            )
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(width*0.328, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                IconButton(onPressed: (){State((){});_Value=selectedmaxleverage*0.4;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                                Text(selectedmaxleverage4.round().toString()+"x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                              ],
                                                            )
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(width*0.496, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                IconButton(onPressed: (){State((){});_Value=selectedmaxleverage*0.6;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                                Text(selectedmaxleverage6.round().toString()+"x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                              ],
                                                            )
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(width*0.666, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                IconButton(onPressed: (){State((){});_Value=selectedmaxleverage*0.8;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                                Text(selectedmaxleverage8.round().toString()+"x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                              ],
                                                            )
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.fromLTRB(width*0.833, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                IconButton(onPressed: (){State((){});_Value=selectedmaxleverage*1.0;set((){});},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                                Text(selectedmaxleverage.round().toString()+"x",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                              ],
                                                            )
                                                        ),
                                                      ],
                                                    );

                                                  },),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.circle,color: Colors.grey[500],size: 8),
                                                    Text(" You can only increase leverage when holding positions, please",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.grey[500]),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 13,),
                                                    Text("   mind the impact yo your holding position.",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.grey[500]),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.circle,color: Colors.grey[500],size: 8),
                                                    Text(" Please note that leverage changing will also apply for open",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.grey[500]),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 13,),
                                                    Text("   positions and open orders.",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.grey[500]),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                SizedBox(height: 8,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 5),
                                                    Icon(Icons.warning,color: Colors.red,size: 18),
                                                    Text(" Selceting higher leverage such as [10x] increases liquidation",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.red),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 23),
                                                    Text(" risk.Alaways manage your risk levels.",maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.red),overflow: TextOverflow.ellipsis ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 40,
                                                  color: Theme.of(context).buttonColor,
                                                  margin: EdgeInsets.fromLTRB(30, 25, 30, 15),
                                                  child: TextButton(onPressed: (){
                                                    leverage = _Value ;
                                                    setState((){});
                                                    Navigator.pop(context);
                                                  },

                                                      child: Center(child: Text('Confirm',style: TextStyle(color: Colors.white ,fontSize: 20),))
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );},
                                    );

                                  },
                                  );

                                },
                              ),
                              Container(
                                height: 30,
                                width: width*0.07,
                                color: Theme.of(context).primaryColor,
                                child: Center(
                                  child: Text("S",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width*0.08,),
                          Container(
                            width: width*0.25,
                            child:Column(
                              children: [
                                Text("Funding/Countdown",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),maxLines: 1 ,
                                ),
                                Text("0.0100% / 03:17:53",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(child: Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width*0.6 ,
                            height: 20,
                            child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              labelStyle: TextStyle(fontSize:14),
                              isScrollable: false,
                              controller: _tabController,
                              labelColor: Colors.amber,
                              unselectedLabelColor: Theme.of(context).cardColor,
                              indicator:BoxDecoration(color: Theme.of(context).canvasColor) ,
                              tabs: [
                                Tab(text:"Limit",),
                                Tab(text:"Market"),
                                Tab(child: Container(child: Text("StopLimit ")),),
                              ],
                            ),
                          ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                                child: IconButton(onPressed: (){}, icon: Icon(Icons.info,size: 20,color: Theme.of(context).cardColor,))
                            ),
                        ],
                      ),

                      Container(
                        height: height*0.63,
                        width: width,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 20 ,),
                                Row(
                                  children: [
                                    SizedBox(width: 33),
                                    Text("Avbl",style: TextStyle(color: Theme.of(context).cardColor),),
                                    SizedBox(width: 10),
                                    Text("$wallet"+"USDT",style: TextStyle(color: Colors.white,fontSize: 15),),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: (){},
                                      child: Icon(Icons.add_box,color: Colors.amber,size: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xff2b3139),),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width*0.6,
                                        child: TextFormField(
                                          controller: text7Controller,
                                          decoration: InputDecoration(
                                            hintText: "Price",
                                            hintStyle: TextStyle(fontSize: 18,color: Theme.of(context).cardColor),
                                            border: InputBorder.none,
                                          ) ,
                                          cursorColor: Colors.amber,
                                          keyboardType:TextInputType.number ,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],

                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){},
                                            child: Text("LAST",style: TextStyle(color: Colors.amber,fontSize: 14)),
                                          ),
                                          Text("   USDT",style: TextStyle(color: Colors.white,fontSize: 17)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xff2b3139),),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width*0.55,
                                        child: TextFormField(
                                          onTap: (){},

                                          decoration: InputDecoration(
                                            hintText: "Size",
                                            hintStyle: TextStyle(fontSize: 18,color: Theme.of(context).cardColor),
                                            border: InputBorder.none,
                                          ) ,
                                          cursorColor: Colors.amber,
                                          keyboardType:TextInputType.number ,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],

                                        ),
                                      ),
                                      Text(leverage.round().toString() + " %",style: TextStyle(color: Colors.white,),),
                                      InkWell(
                                        onTap: (){
                                          if (sizecurency == "USDT"){sizecurency="BTC";}
                                          else {sizecurency= "USDT";}
                                          setState((){});
                                        },
                                        child: Row(
                                          children: [
                                            Text("$sizecurency",style: TextStyle(color: Colors.white,fontSize: 17),),
                                            SizedBox(width: 2,),
                                            Icon(Icons.rotate_left,color: Colors.white,size: 20,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10,20,10,0),
                                  width: width*0.95,
                                  child: StatefulBuilder(builder: (context, set) {
                                    return  Stack(
                                      children:[

                                        Container(
                                          width: width*0.95,
                                          child: SliderTheme(
                                            data: SliderThemeData(
                                              inactiveTickMarkColor: Colors.blue,
                                              activeTickMarkColor: Colors.red,
                                              trackHeight: 5,
                                            ),
                                            child: Slider(
                                              autofocus: true,
                                              value: leverage,
                                              label: _Value.round().toString(),
                                              activeColor: Colors.grey[600],
                                              min: 1,
                                              max: selectedmaxleverage.toDouble(),
                                              divisions: selectedmaxleverage-1,
                                              onChanged: (double e){

                                                leverage= e;
                                                setState(() {
                                                });



                                              },

                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            IconButton(onPressed: (){leverage=1;setState((){});_Value=1;},icon: Icon(Icons.circle,color: Colors.grey,size: 15,),),
                                            Text("   0%",style: TextStyle(fontSize: 14,color: Colors.white),),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(width*0.203, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                IconButton(onPressed: (){leverage=selectedmaxleverage/4;setState((){});_Value=selectedmaxleverage/4;},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                Text("  25%",style: TextStyle(fontSize: 14,color: Colors.white),),
                                              ],
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(width*0.413, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                IconButton(onPressed: (){leverage=selectedmaxleverage/2;setState((){});_Value=selectedmaxleverage/2;},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                Text("  50%",style: TextStyle(fontSize: 14,color: Colors.white),),
                                              ],
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(width*0.623, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                IconButton(onPressed: (){leverage=selectedmaxleverage*0.75;setState((){});_Value=selectedmaxleverage*0.75;},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                Text("  75%",style: TextStyle(fontSize: 14,color: Colors.white),),
                                              ],
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(width*0.833, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                IconButton(onPressed: (){leverage=selectedmaxleverage*1.0;setState((){});_Value=selectedmaxleverage*1.0;},icon: Icon(Icons.circle,color: Colors.grey,size: 15,)),
                                                Text(" 100%",style: TextStyle(fontSize: 14,color: Colors.white),),
                                              ],
                                            )
                                        ),
                                      ],
                                    );

                                  },),
                                ),
                                SizedBox(height: 18),
                                Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 10),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Checkbox(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      value: TPSLcheckbox,
                                      onChanged: (er){
                                        TPSLcheckbox= er! ;
                                        setState((){});
                                        if (Reduceonlycheckbox= true) {Reduceonlycheckbox = !Reduceonlycheckbox;};
                                      },
                                      activeColor: Colors.amber,
                                      checkColor: Theme.of(context).backgroundColor,
                                    ),
                                    Text("TP/SL",style: TextStyle(fontSize: 15,color: Colors.white),),
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
                                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xff2b3139),),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: width*0.6,
                                                child: TextFormField(
                                                  onTap: (){},

                                                  decoration: InputDecoration(
                                                    hintText: "Take Profit",
                                                    hintStyle: TextStyle(fontSize: 18,color: Theme.of(context).cardColor),
                                                    border: InputBorder.none,
                                                  ) ,
                                                  cursorColor: Colors.amber,
                                                  keyboardType:TextInputType.number ,
                                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],

                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text("   USDT",style: TextStyle(color: Colors.white,fontSize: 17)),
                                                ],
                                              ),
                                            ],
                                          ),

                                        ),
                                        Container(
                                          height: 50,
                                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xff2b3139),),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: width*0.6,
                                                child: TextFormField(
                                                  onTap: (){},

                                                  decoration: InputDecoration(
                                                    hintText: "Stop Loss",
                                                    hintStyle: TextStyle(fontSize: 18,color: Theme.of(context).cardColor),
                                                    border: InputBorder.none,
                                                  ) ,
                                                  cursorColor: Colors.amber,
                                                  keyboardType:TextInputType.number ,
                                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],

                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text("   USDT",style: TextStyle(color: Colors.white,fontSize: 17)),
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
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: Reduceonlycheckbox,
                                        onChanged: (er){
                                          Reduceonlycheckbox= er! ;
                                          setState((){});
                                          if (TPSLcheckbox= true) {TPSLcheckbox = !TPSLcheckbox;};
                                        },
                                        activeColor: Colors.amber,
                                        checkColor: Theme.of(context).backgroundColor,
                                      ),
                                      Text("Reduce-Only",style: TextStyle(fontSize: 15,color: Colors.white),),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width*0.43,
                                      height: height*0.065,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.green),
                                        ),
                                        onPressed: () async {
                                          /*await UpdateContactBoolean("order1",true);
                                          await new Future.delayed(new Duration(milliseconds: 1000));
                                          if(order1==true){
                                           order1visibility=true;
                                          }*/
                                          await new Future.delayed(new Duration(milliseconds: 1000));

                                          if (order1==false) {
                                          order1time = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
                                          await UpdateContactString("entryPrice1",text7Controller.text);
                                          await UpdateContactString("pair1",selctedcrypto);
                                          await UpdateContactString("order1time",order1time);
                                          await UpdateContactDouble("leverage1",leverage);
                                          await UpdateContactBoolean("order1", true);
                                          await new Future.delayed(new Duration(milliseconds: 1000));
                                          orderitemcount +=1;
                                          order1pairs=selctedcrypto;
                                          }
                                           else if (order2==false) {
                                            order2time = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
                                            await UpdateContactString("entryPrice2",text7Controller.text);
                                            await UpdateContactString("pair2",selctedcrypto);
                                            await UpdateContactString("order2time",order2time);
                                            await UpdateContactDouble("leverage2",leverage);
                                            await UpdateContactBoolean("order2", true);
                                            await new Future.delayed(new Duration(milliseconds: 1000));
                                            orderitemcount +=1;
                                            order2pairs=selctedcrypto;
                                          }
                                          else if (order3==false) {

                                           order3time = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
                                          await UpdateContactString("entryPrice3",text7Controller.text);
                                          await UpdateContactString("pair3",selctedcrypto);
                                           await UpdateContactString("order3time",order3time);
                                           await UpdateContactDouble("leverage3",leverage);
                                          await UpdateContactBoolean("order3", true);
                                          await new Future.delayed(new Duration(milliseconds: 1000));
                                          orderitemcount +=1;
                                          order3pairs=selctedcrypto;
                                          };

                                          setState((){});

                                        }

                                        , child: Text("Buy/Long"),
                                      ),
                                    ),
                                    Container(
                                      width: width*0.43,
                                      height: height*0.065,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red),
                                        ),
                                        onPressed: () async {


                                        }
                                        , child: Text("Sell/Short"),
                                      ),
                                    ),
                                  ],
                                ),




                              ],
                            ),
                            Text("2"),
                            Text("3"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(17, 20, 0, 10),
                            width: width*0.5 ,
                            height: 20,
                            child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              isScrollable: false,
                              controller: _tabController2,
                              labelColor: Colors.amber,
                              unselectedLabelColor: Theme.of(context).cardColor,
                              indicator:BoxDecoration(color: Theme.of(context).canvasColor) ,
                              tabs: [
                                Tab(text:"Open Orders($orderitemcount)"),
                                Tab(text:"Positions(0)"),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
                      SizedBox(height: 10),
                      Container(
                        width: width*0.95,
                        height:500,
                        child: TabBarView(
                          controller: _tabController2,
                          children: [
                            Column(
                              children: [
                                Visibility(
                                  visible: order1,
                                  child: Container(
                                    height: 150,
                                    width: width,
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("$order1pairs Perpetual",style: TextStyle(color:Colors.white,fontSize: 17 ),),
                                            Text("$order1time" ,style: TextStyle(color:Colors.white,fontSize: 13 ),),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Limt/Buy",style: TextStyle(fontSize: 18,color: Colors.green ),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 15),
                                            CircleAvatar(
                                              backgroundColor: Theme.of(context).primaryColor,
                                              radius: 20 ,
                                              child:CircleAvatar(
                                                backgroundColor: Theme.of(context).backgroundColor,
                                                radius: 16,
                                                child: Text("0%",style: TextStyle(fontSize: 16,color: Colors.green),),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text("Amont \n (BTC)",style: TextStyle(fontSize: 15,color: Colors.grey),),
                                            SizedBox(width: 30),
                                            Text("0000",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 75),
                                            Text("Price",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                            SizedBox(width: 37 ),
                                            Text("$entryPrice1",style: TextStyle(fontSize: 16,color: Colors.white),),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 25,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),), //Theme.of(context).primaryColor
                                                      onPressed:() async {
                                                        await UpdateContactBoolean("order1",false);
                                                        await new Future.delayed(new Duration(milliseconds: 1000));
                                                        if(order1==false){
                                                          await UpdateContactString("entryPrice1", "0");
                                                          orderitemcount-=1;
                                                        }
                                                        setState((){});
                                                      },
                                                      child: Center(child: Text("Cancel",style: TextStyle(fontSize: 14,color: Colors.white),)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: order2,
                                  child: Container(
                                    height: 150,
                                    width: width,
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("$order2pairs Perpetual",style: TextStyle(color:Colors.white,fontSize: 17 ),),
                                            Text("$order2time" ,style: TextStyle(color:Colors.white,fontSize: 13 ),),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Limt/Buy",style: TextStyle(fontSize: 18,color: Colors.green ),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 15),
                                            CircleAvatar(
                                              backgroundColor: Theme.of(context).primaryColor,
                                              radius: 20 ,
                                              child:CircleAvatar(
                                                backgroundColor: Theme.of(context).backgroundColor,
                                                radius: 16,
                                                child: Text("0%",style: TextStyle(fontSize: 16,color: Colors.green),),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text("Amont \n (BTC)",style: TextStyle(fontSize: 15,color: Colors.grey),),
                                            SizedBox(width: 30),
                                            Text("0000",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 75),
                                            Text("Price",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                            SizedBox(width: 37 ),
                                            Text("$entryPrice2",style: TextStyle(fontSize: 16,color: Colors.white),),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 25,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),), //Theme.of(context).primaryColor
                                                      onPressed:() async {
                                                        await UpdateContactBoolean("order2",false);
                                                        await new Future.delayed(new Duration(milliseconds: 1000));
                                                        if(order2==false){
                                                          await UpdateContactString("entryPrice2", "0");
                                                          orderitemcount-=1;
                                                        }
                                                        setState((){});
                                                      },
                                                      child: Center(child: Text("Cancel",style: TextStyle(fontSize: 14,color: Colors.white),)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("$order3pairs Perpetual",style: TextStyle(color:Colors.white,fontSize: 17 ),),
                                            Text("$order3time" ,style: TextStyle(color:Colors.white,fontSize: 13 ),),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Limt/Buy",style: TextStyle(fontSize: 18,color: Colors.green ),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 15),
                                            CircleAvatar(
                                              backgroundColor: Theme.of(context).primaryColor,
                                              radius: 20 ,
                                              child:CircleAvatar(
                                                backgroundColor: Theme.of(context).backgroundColor,
                                                radius: 16,
                                                child: Text("0%",style: TextStyle(fontSize: 16,color: Colors.green),),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text("Amont \n (BTC)",style: TextStyle(fontSize: 15,color: Colors.grey),),
                                            SizedBox(width: 30),
                                            Text("0000",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 75),
                                            Text("Price",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                            SizedBox(width: 37 ),
                                            Text("$entryPrice3",style: TextStyle(fontSize: 16,color: Colors.white),),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 25,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),), //Theme.of(context).primaryColor
                                                      onPressed:() async {
                                                        await UpdateContactBoolean("order3",false);
                                                        await new Future.delayed(new Duration(milliseconds: 1000));
                                                        if(order3==false){
                                                          await UpdateContactString("entryPrice3", "0");
                                                          orderitemcount-=1;
                                                        }
                                                        setState((){});
                                                      },
                                                      child: Center(child: Text("Cancel",style: TextStyle(fontSize: 14,color: Colors.white),)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            Column(
                              children: [
                                Visibility(
                                  visible: position1,
                                    child: Container(
                                      width:width,
                                      height: 130,
                                      margin: EdgeInsets.fromLTRB(10,0, 5, 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "$pair1".toUpperCase()+"USDT",
                                                        style: TextStyle(fontSize: 16,color: Colors.white),
                                                      ),
                                                      SizedBox(width: 5), 
                                                      Container(
                                                        width: 40,
                                                        height: 20,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color: TypeOfColor(longorshort1),),
                                                        child: Center(
                                                          child: Text(
                                                            "$buyorsell1",
                                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Cross",
                                                    style: TextStyle(fontSize: 12,color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 5),

                                              //SizedBox(width: width*0.37),
                                              Padding(
                                                padding: EdgeInsets.all(1),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [
                                                   Text(
                                                       "Unrealized P&L",
                                                     style: TextStyle(fontSize: 12,color: Colors.white),
                                                   ),
                                                   Text(
                                                     pnl1+'('+pnlp1+')',
                                                     style: TextStyle(fontSize: 12,color: pnlc1,fontWeight: FontWeight.bold),
                                                   )
                                                 ],
                                                ),
                                              )
                                            ],
                                          ),
                                          //SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Position Size",
                                                    style:TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "0.02",
                                                    style:TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Entry Price",
                                                    style:TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    entryPrice1,
                                                    style:TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Mark Price",
                                                    style:TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$markprice1",
                                                    style:TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Liq Price",
                                                    style:TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "9999.0",
                                                    style:TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width:width*0.4,
                                                height: 40, 
                                                child: ElevatedButton(
                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                    onPressed: () => _dialogBuilder(context,"takeProfit1","stopLoss1",markprice1,longorshort1),
                                                    child: Text("TP/Sl"),
                                                ),
                                              ),
                                              Container(
                                                width:width*0.4,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                  onPressed: (){},
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
                                  visible: position2,
                                  child: Container(
                                    width:width,
                                    height: 130,
                                    margin: EdgeInsets.fromLTRB(10,10, 5, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                      children: [
                                        Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$pair1".toUpperCase()+"USDT",
                                                  style: TextStyle(fontSize: 16,color: Colors.white),
                                                ),
                                                Text(
                                                  "Cross",
                                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 40,
                                              height: 20,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color: TypeOfColor(longorshort1),),
                                              child: Center(
                                                child: Text(
                                                  "$buyorsell1",
                                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width*0.37),
                                            Padding(
                                              padding: EdgeInsets.all(1),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Unrealized P&L",
                                                    style: TextStyle(fontSize: 12,color: Colors.white),
                                                  ),
                                                  Text(
                                                    deuxchiffre((unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2)).toString()+"("+deuxchiffre((unrealizedpnl("16000", markprice2, longorshort2, leverage2,position2)*100)).toString()+"%)" ,
                                                    style: TextStyle(fontSize: 12,color: unrealizedpnl_color(unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2),fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        //SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Position Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "0.02",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Entry Price Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "3087.4",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Mark Price Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  markprice2,
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Liq Price",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "9999.0",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width:width*0.4,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                onPressed: (){},
                                                child: Text("TP/Sl"),
                                              ),
                                            ),
                                            Container(
                                              width:width*0.4,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                onPressed: (){},
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
                                    width:width,
                                    height: 130,
                                    margin: EdgeInsets.fromLTRB(10,10, 5, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                      children: [
                                        Divider(color: Theme.of(context).cardColor,endIndent: width*0.04,indent: width*0.05,thickness: 0.4 ,height: 8 ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$pair1".toUpperCase()+"USDT",
                                                  style: TextStyle(fontSize: 16,color: Colors.white),
                                                ),
                                                Text(
                                                  "Cross",
                                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 40,
                                              height: 20,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color: TypeOfColor(longorshort1),),
                                              child: Center(
                                                child: Text(
                                                  "$buyorsell1",
                                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width*0.37),
                                            Padding(
                                              padding: EdgeInsets.all(1),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Unrealized P&L",
                                                    style: TextStyle(fontSize: 12,color: Colors.white),
                                                  ),
                                                  Text(
                                                    deuxchiffre((unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*quantity3)).toString()+"("+deuxchiffre((unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*100)).toString()+"%)" ,
                                                    style: TextStyle(fontSize: 12,color: unrealizedpnl_color(unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*quantity3),fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        //SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Position Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "0.02",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Entry Price Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "3087.4",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Mark Price Size",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  markprice3,
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Liq Price",
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "9999.0",
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width:width*0.4,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                onPressed: (){},
                                                child: Text("TP/Sl"),
                                              ),
                                            ),
                                            Container(
                                              width:width*0.4,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff2b3139)),),
                                                onPressed: (){},
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
    );

  }

  var channel2 = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/ethusdt@aggTrade');



  streamListener4() {
    channel2.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        ethUsdtPrice = getData['p'];
      });
      // print(getData['p']);
    });
  }

  streamListener(String pair) {
    var channel1 = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/'+pair+'usdt@aggTrade');
    channel1.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });
      // print(getData['p']);
    });
  }
  streamListener1(String pair) {
    var channel1 = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/'+pair+'usdt@aggTrade');
    channel1.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice1 = getData['p'];
      });
      // print(getData['p']);
    });
  }
  streamListener2(String pair) {
    var channel1 = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/'+pair+'usdt@aggTrade');
    channel1.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice2 = getData['p'];
      });
      // print(getData['p']);
    });
  }
  streamListener3(String pair) {
    var channel1 = IOWebSocketChannel.connect('wss://fstream.binance.com/ws/'+pair+'usdt@aggTrade');
    channel1.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        markprice3 = getData['p'];
      });
      // print(getData['p']);
    });
  }
 /* streamListenerr() {
    Timer mytimer = Timer.periodic(Duration(seconds:3), (timer) {
      updatecontact();
    });
  }*/


  Future Getcontact() async {
    String url ="http://"+api+":8011/contacts/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
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

  Future TypeOfTrade() async{
   if(longorshort1==true){buyorsell1 = "Long";}
   else if(longorshort1==false){buyorsell1 = "Short";}
   if(longorshort2==true){buyorsell2 = "Long";}
   else if(longorshort2==false){buyorsell2 = "Short";}
   if(longorshort3==true){buyorsell3 = "Long";}
   else if(longorshort3==false){buyorsell3 = "Short";}
  }
  TypeOfColor(bool x){
    if (x==true){return Colors.green;}
    else if (x==false){return Colors.red;}
  }

  Future UpdateContactBoolean(String parametre,bool bool) async {
    String url = "http://"+api+":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
    var res = await http.put(Uri.parse(url),
        headers: {
        "Content-type": "application/json",
          'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJZb3NyeTIyMiIsImV4cCI6MTY2OTEyNDc5Nn0.d2CLMdymyw-7w5fdY8bs0wvwE47YMiK9-2xtTnOqSyJ8IwaGTxGAbMYlZK3epinfjte3ipw3-LMRZAec4dWH-Q',
        },
        body: json.encode({parametre: bool}));
    print(res.statusCode);
    if (res.statusCode == 202) {
      print("updated");
    }
  }

  Future UpdateContactString(String parametre,String string) async {
    String url = "http://"+api+":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
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

  Future UpdateContactDouble(String parametre,double double) async {
    String url = "http://"+api+":8011/contacts/wallet/qQDC0yzzo8dBSxwNG9IvkScM8ozcbs";
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

  Color unrealizedpnl_color(double x){
    if(x<0){return Colors.red;}
    else if(x==0){return Colors.white;}
    else {return Colors.green;}
  }

  double unrealizedpnl(String entryprice,String markprice,bool longorshort,double leverage,bool position){
    if(position==true) {
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
    else{return 0.0;}
  }
  String verifytrueorfalse(bool position,String x){
    if (position==true){return x;}
    else {return "x";}
  }
  double deuxchiffre(double x){
    int s = ((x-x.roundToDouble())*100).toInt();
    double n = x.roundToDouble();
    if(s>=50){n=n-1;}
    return n+s/100;
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

  Future<void> _dialogBuilder(BuildContext context,String x,String y,String markprice00,bool typeoftrde0) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          buttonPadding:EdgeInsets.zero ,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
           Container(
             padding: EdgeInsets.symmetric(horizontal: 10),
             width: width*0.8,
             height: height*0.34,
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
                       "Takeprofit/Stoploss",
                       style: TextStyle(color: Colors.white,fontSize: 18 ),
                     ),
                     IconButton(
                         onPressed: (){Navigator.pop(context);},
                         icon:Icon(Icons.close,color: Theme.of(context).cardColor,size: 20,) ),
                   ],
                 ),
                 SizedBox(height: 10),
                 Text(
                   "Takeprofit",
                   style: TextStyle(color: Theme.of(context).cardColor,fontSize: 15 ),
                 ),
                 SizedBox(height: 3),
                 Container(
                   width: width*0.75,
                   height: height*0.045,
                   decoration:BoxDecoration(color:Color(0xff2b3139)),
                   child: TextFormField(
                     controller: text1Controller,
                     decoration: InputDecoration(
                       hintText: "Take Profit",
                       hintStyle: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),
                       border: InputBorder.none,
                     ) ,
                     cursorColor: Colors.amber,
                     keyboardType:TextInputType.number ,
                     inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],
                   ),
                 ),
                 SizedBox(height: 10),
                 Text(
                   "Stop Loss",
                   style: TextStyle(color: Theme.of(context).cardColor,fontSize: 15 ),
                 ),
                 SizedBox(height: 3),
                 Container(
                   width: width*0.75,
                   height: height*0.045,
                   decoration:BoxDecoration(color:Color(0xff2b3139)),
                   child: TextFormField(
                     controller: text2Controller,
                     decoration: InputDecoration(
                       hintText: "Stop Loss",
                       hintStyle: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),
                       border: InputBorder.none,
                     ) ,
                     cursorColor: Colors.amber,
                     keyboardType:TextInputType.number ,
                     inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],
                   ),
                 ),
                 SizedBox(height: 10),
                 Center(
                   child: Container(
                     width: width*0.3,
                     height: height*0.05,
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular(5),color: Colors.deepPurple),
                     child: TextButton(
                         onPressed: () async{
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
                           print(AA);
                           print(BB);
                           if(BB==2&&AA==2 || BB==2&&AA==0 || BB==0&&AA==2 ){
                             print("done");
                             if(AA==2){
                             await UpdateContactString("$x",text1Controller.text);
                           }
                             if(BB==2) {
                               await UpdateContactString("$y", text2Controller.text);
                             }
                             Navigator.pop(context);
                             print("done");
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


  @override
  void initState()  {
    super.initState();
    if(position1==true){streamListener1(pair1);}
    if(position2==true){streamListener2(pair2);}
    if(position3==true){streamListener3(pair3);}
    streamListener('btc');
    streamListener4();
    Timer mytimer = Timer.periodic(Duration(seconds:1 ), (timer) async {
      TypeOfTrade();
      await Getcontact();
      if(position1==true){
        streamListener1(pair1);
        pnl1=deuxchiffre((unrealizedpnl(entryPrice1, markprice1, longorshort1, leverage1,position1)*quantity1)).toString();
        pnlp1=deuxchiffre((unrealizedpnl(entryPrice1, markprice1, longorshort1, leverage1,position1)*100)).toString();
        pnlc1=unrealizedpnl_color(unrealizedpnl(entryPrice1, markprice1, longorshort1, leverage1,position1)*quantity1);
        // deuxchiffre((unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2)).toString()+"("+deuxchiffre((unrealizedpnl("16000", markprice2, longorshort2, leverage2,position2)*100)).toString()+"%)"

      }
      if(position2==true){
        streamListener2(pair2);
        pnl2=deuxchiffre((unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2)).toString();
        pnlp2=deuxchiffre((unrealizedpnl("16000", markprice2, longorshort2, leverage2,position2)*100)).toString();
        pnlc2=unrealizedpnl_color(unrealizedpnl(entryPrice2, markprice2, longorshort2, leverage2,position2)*quantity2);
      }
      if(position3==true){
        streamListener3(pair3);
        pnl3=deuxchiffre((unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*quantity3)).toString();
        pnlp3=deuxchiffre((unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*100)).toString();
        pnlc3=unrealizedpnl_color(unrealizedpnl(entryPrice3, markprice3, longorshort3, leverage3,position3)*quantity3);
      }

    });
  }

}









