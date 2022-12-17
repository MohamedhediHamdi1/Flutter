import 'dart:convert';

import 'package:cryptoo/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../admob/adReward.dart';

class Static_screen extends StatefulWidget {
  const Static_screen({Key? key}) : super(key: key);

  @override
  State<Static_screen> createState() => _Static_screenState();
}

class _Static_screenState extends State<Static_screen> {

  var size, height, width;
  String day1="Mon";
  String day2="Mon";
  String day3="Mon";
  String day4="Mon";
  String day5="Mon";
  String day6="Mon";
  String day7="Mon";
  List<String> days = ["MON","TUE","WED","THU","FRI","SAT","SUN"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: RefreshIndicator(
          color: Color(0xff246EE9),
          onRefresh: ()async{
            await test();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 50,
                  color: Theme.of(context).backgroundColor,
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
                        icon: Icon(Icons.arrow_back,color: Color(0xff246EE9)),
                      ),
                      Text(
                          "P&L Analysis",
                        style: GoogleFonts.ptSerif(
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Total Assets",
                            style: GoogleFonts.roboto(
                              color: Theme.of(context).cardColor,
                              fontSize: 15
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            wallet+" USD",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "=0.00000 BTC",
                            style: GoogleFonts.roboto(
                                color: Theme.of(context).cardColor,
                                fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Today's P&L",
                                style: GoogleFonts.roboto(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 15
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "$pnl7 USD",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "7 Day's PnL",
                                style: GoogleFonts.roboto(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 15
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                (pnl1+pnl2+pnl3+pnl4+pnl5+pnl6+pnl7).toString()+" USD",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: width,
                  color: Theme.of(context).canvasColor,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Last 7 Days",
                      style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18
                  ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            //maximum: 7,
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            minimum: 0, maximum: 35, interval: 10,
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                          ),
                          plotAreaBorderColor: Colors.transparent,
                          tooltipBehavior: _tooltip!,
                          backgroundColor: Theme.of(context).canvasColor,
                          series: <ChartSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                                dataSource: data,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                name: 'Gold',
                                width: 0.8,
                                spacing: 0.1,
                                //color: Colors.green,
                              pointColorMapper:(_ChartData data, _) => data.color,
                            )
                          ]),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  late List<_ChartData> data;
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    data = [
      _ChartData(day1, pnl1,find_color(pnl1)),
      _ChartData(day2, pnl2,find_color(pnl2)),
      _ChartData(day3, pnl3,find_color(pnl3)),
      _ChartData(day4, pnl4,find_color(pnl4)),
      _ChartData(day5, pnl5,find_color(pnl5)),
      _ChartData(day6, pnl6,find_color(pnl6)),
      _ChartData(day7, pnl7,find_color(pnl7))
    ];
    test();

  super.initState();
  }
  late TooltipBehavior _tooltip;

  Future<void> test() async{
    var now = new DateTime.now();
    var formatter = new DateFormat('EEEE');
    String today = formatter.format(now);
    today=today.substring(0,3).toUpperCase();
    int i =days.indexOf(today);
    day7=today;
    if(i-1<0){
      day6=days[i-1+7];
    }
    else{day6=days[i-1];}
    if(i-2<0){
      day5=days[i-2+7];
    }
    else{day5=days[i-2];}
    if(i-3<0){
      day4=days[i-3+7];
    }
    else{day4=days[i-3];}
    if(i-4<0){
      day3=days[i-4+7];
    }
    else{day3=days[i-4];}
    if(i-5<0){
      day2=days[i-5+7];
    }
    else{day2=days[i-5];}
    if(i-6<0){
      day1=days[i-6+7];
    }
    else{day1=days[i-6];}

    user_id = await storage.read(key: "user_id");
    token = await storage.read(key: "token");
    contact_id = await storage.read(key: "contact_id");
    await Getcontact1();
    await Getcontact();
    _tooltip = TooltipBehavior(enable: true);
    data = [
      _ChartData(day1, pnl1,find_color(pnl1)),
      _ChartData(day2, pnl2,find_color(pnl2)),
      _ChartData(day3, pnl3,find_color(pnl3)),
      _ChartData(day4, pnl4,find_color(pnl4)),
      _ChartData(day5, pnl5,find_color(pnl5)),
      _ChartData(day6, pnl6,find_color(pnl6)),
      _ChartData(day7, pnl7,find_color(pnl7))
    ];
    print(user_id);
    setState(() {});
  }
  Color find_color(double pnl){
    if(pnl<0){
      return Colors.red;
    }
    else if(pnl>0){
      return Colors.green;
    }
    else{
      return Colors.white;
    }
  }
  final storage = new FlutterSecureStorage();
  String? user_id = "";
  String? token ="";
  String api = ConstantVar.api;
  double pnl1=0;
  double pnl2=0;
  double pnl3=0;
  double pnl4=0;
  double pnl5=0;
  double pnl6=0;
  double pnl7=0;
  Future Getcontact() async {
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
  pnl1= jsonData["day1"];
  pnl2= jsonData["day2"];
  pnl3= jsonData["day3"];
  pnl4= jsonData["day4"];
  pnl5= jsonData["day5"];
  pnl6= jsonData["day6"];
  pnl7= jsonData["day7"];
  }
  }
  String? contact_id = "";
  String wallet ="0";
  Future Getcontact1() async {
    String url = "http://" + api +
        ":8011/contacts/$contact_id";
    try{
      print(contact_id);
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

}
class _ChartData {
  _ChartData(this.x, this.y,this.color);
  final String x;
  final double y;
  final Color color;
}