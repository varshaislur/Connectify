import 'dart:ui';

import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  String commentMessage;
  String commentedBy;
  Comment({super.key,required this.commentMessage,required this.commentedBy});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),


              ),
              width:MediaQuery.of(context).size.width-10,
              // height:100,
                      child: Stack(
                        children: [
                      //blur effect
                      BackdropFilter(filter:
                      ImageFilter.blur(
                      sigmaX:10,
                        sigmaY:10 ,
                      ),
                      child: Container(),),
                    //gradient effect
                    Container(
                        width:MediaQuery.of(context).size.width-10 ,
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
            Colors.grey.withOpacity(0.3),
            Colors.grey.withOpacity(0.3)
            ],

    )
    ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(commentMessage,style: TextStyle(
                      color: Colors.white,
                    ),),
                    SizedBox(height:10),
                    Text(commentedBy,style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                    ),),

                  ],
                ),
              ),
    ),
    ]
    ),
    ),
    ),
    );
  }
}
