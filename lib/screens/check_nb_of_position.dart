
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void Check_nb_Position(BuildContext context)  {

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
                width:width*0.6 ,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Color(0xff246EE9)),
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children:  [
                    SizedBox(height: 15),
                    Text(
                      "The maximum number of orders is 4",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
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






