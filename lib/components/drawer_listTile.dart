import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  IconData icon;
  String tilemessage;
  void Function()? onTap;
  DrawerListTile({super.key,required this.icon,required this.tilemessage,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: Colors.white,),
        title:Text(tilemessage,style: TextStyle(
          color: Colors.white
        ),),
      onTap: onTap,

    );
  }
}
