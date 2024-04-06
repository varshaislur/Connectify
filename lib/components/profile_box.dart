import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  String sectionTitle;
  String sectionValue;
  void Function()? onEditPressed;
  ProfileTile({super.key,required this.sectionTitle,required this.sectionValue,required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
        child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),


    ),
      width:MediaQuery.of(context).size.width-10,
      // height:70,
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
                  width: MediaQuery.of(context).size.width,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sectionTitle,style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15,

                                  ),),
                                  IconButton(onPressed:onEditPressed, icon: Icon(Icons.edit)),
                                ],
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                  thickness: 0.2,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15,left: 15,right: 8.0,top: 10),
                              child: Text(sectionValue,style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                              ),),
                            ),

                          ],
                        ),
    ),
    ]
    ),
    ),
    ),
    );

  }
}
