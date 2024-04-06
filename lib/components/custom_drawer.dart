import 'package:connectify/components/drawer_listTile.dart';
import 'package:connectify/screens/profile_page.dart';
import 'package:connectify/services/auth/user_functions.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      child:Column(
        children: [
          //header
          DrawerHeader(child:
          Icon(Icons.person,color: Colors.white,size: 40,)),
          //home list tile
          DrawerListTile(icon: Icons.home, tilemessage:"H O M E", onTap: () {
            Navigator.pop(context);
          },),

          //profile list tile
          DrawerListTile(icon: Icons.perm_contact_cal, tilemessage:"P R O F I L E", onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
          },),
          //logout list tile
          DrawerListTile(icon: Icons.logout, tilemessage:"L O G  O U T", onTap: () {
            UserFunctions().usersignout();
          },),
        ],
      )
    );
  }
}
