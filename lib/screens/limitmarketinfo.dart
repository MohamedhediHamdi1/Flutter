
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void limit_market_info(BuildContext context)  {

   showDialog<void>(

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
                height: 190,
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Color(0xff246EE9)),
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children:  [
                    SizedBox(height: 20),
                    const Text(
                        "- Limit Order allows you to place an order at a specific or a better price. Please note that a Limit Order is not guaranteed to execute.",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    const Text(
                        "- Market orders are matched immediately at the best available price.",
                        style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xff246EE9),
                          ),
                          height: 30,
                          width: 100,
                          child: Center(
                            child: const Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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






