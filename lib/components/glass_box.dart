import 'dart:ui';


import 'package:flutter/material.dart';

import 'like_button.dart';
//this is a trial widget
class GlassBox extends StatefulWidget {
  const GlassBox({super.key});

  @override
  State<GlassBox> createState() => _GlassBoxState();
}

class _GlassBoxState extends State<GlassBox> {
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
          height:100,
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
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5)
                    ],

                  )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 50,
                          width:50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO	(239,187,255,1),

                          ),
                          child: Icon(Icons.person),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("message",style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("message",style: TextStyle(
                              color: Colors.grey,
                            ),),
                          )

                        ],
                      ),
                      Column(children:[
                        LikeButton(isLiked:true, onTap:(){}),
                        Text("1"),
                      ]),
                      //like counter

                    ],

              ),
              ),


            ],
          ),
        
        ),
      ),
    );
  }
}
