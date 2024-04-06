

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/components/profile_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User currentUser= FirebaseAuth.instance.currentUser!;
  TextEditingController usernameController=TextEditingController();
  TextEditingController bioController=TextEditingController();
  String username="";
  String bio="";
  void editUsernamefield() async{
   showDialog(context: context, builder:(context){
     return AlertDialog(
       backgroundColor: Colors.black,
       title:Text("Edit Username",style: TextStyle(
         color: Colors.white,
       ),),
       content: TextField(
         style: TextStyle(
           color: Colors.white,
         ),
         controller: usernameController,
         autofocus: true,
         decoration: InputDecoration(
           hintText: "Enter new username",
           hintStyle: TextStyle(
             color: Colors.white,
           )
         ),

       ),
       actions: [
         ElevatedButton(onPressed: () async{
           if(usernameController.text.isNotEmpty){
           setState(() {
             username=usernameController.text.trim();

           }

           );
           await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update(
               {
                 "username":username,
               });
           usernameController.clear();
           Navigator.pop(context);}
           else{
             print("enter data");
             usernameController.clear();
           }
          }, child: Text("SAVE")),
         ElevatedButton(onPressed: (){
           Navigator.pop(context);
         }, child: Text("CANCEL"))


       ],
     );
   });


  }
  void editBioField() async{
    showDialog(context: context, builder:(context){
      return AlertDialog(
        backgroundColor: Colors.black,
        title:Text("Edit bio",style: TextStyle(
          color: Colors.white,
        ),),
        content: TextField(
          controller: bioController,
          autofocus: true,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
              hintText: "Enter new bio",
              hintStyle: TextStyle(
                color: Colors.white,
              )
          ),

        ),
        actions: [
          ElevatedButton(onPressed: () async{
            if(bioController.text.isNotEmpty){
              setState(() {
                bio=bioController.text.trim();

              }

              );
              await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update(
                  {
                    "user_bio":bio,
                  });
              bioController.clear();
              Navigator.pop(context);}
            else{
              print("enter data");
              bioController.clear();
            }
          }, child: Text("SAVE")),

          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("CANCEL"))

        ],
      );
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:Text("Profile Page",style: TextStyle(
          color: Colors.white
        ),)
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context,  snapshot) {
          Map<String, dynamic> userInfo=snapshot.data!.data() as Map<String,dynamic>;
          if(snapshot.hasData){
            return SafeArea(
              child: Container(
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/animations/background-3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          //profile icon
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top:30),
                              child: Icon(Icons.person,color: Colors.white,size: 75,),
                            ),
                          ),
                          //user email
                          Center(
                            child: Text(currentUser.email!,style: TextStyle(
                              color:Colors.grey,

                            ),),
                          ),

                          SizedBox(height: 20,),
                          //details
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text("DETAILS",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color:Colors.white
                            ),),
                          ),
                          //username
                          ProfileTile(sectionTitle: "username" , sectionValue: userInfo?['username'],onEditPressed:editUsernamefield,),

                          //bio
                          ProfileTile(sectionTitle: "bio" , sectionValue: userInfo?['user_bio'], onEditPressed:editBioField,),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text("MY POSTS",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color:Colors.white
                            ),),
                          ),

                        ]

                    ),
                  ),
                ),
              ),
            );
          }else if(snapshot.hasError){
           return Container(
             child:
             Center(
               child: Text(snapshot.error.toString()) ,
             )
           );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      )
      // body:Container(
      //   decoration:BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/animations/background-3.jpg"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children:[
      //       //profile icon
      //       Center(
      //         child: Padding(
      //           padding: const EdgeInsets.only(top:30),
      //           child: Icon(Icons.person,color: Colors.white,size: 75,),
      //         ),
      //       ),
      //       //user email
      //       Center(
      //         child: Text(user.email!,style: TextStyle(
      //           color:Colors.grey,
      //
      //         ),),
      //       ),
      //
      //       SizedBox(height: 20,),
      //       //details
      //       Padding(
      //         padding: const EdgeInsets.all(20),
      //         child: Text("DETAILS",style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //           color:Colors.white
      //         ),),
      //       ),
      //       //username
      //       ProfileTile(sectionTitle: "username" , sectionValue: "varsha islur",onEditPressed: (){},),
      //
      //       //bio
      //       ProfileTile(sectionTitle: "bio" , sectionValue: "yo wassup", onEditPressed:(){} ,),
      //       Padding(
      //         padding: const EdgeInsets.all(20),
      //         child: Text("MY POSTS",style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20,
      //             color:Colors.white
      //         ),),
      //       ),
      //
      //     ]
      //
      //   ),
      // )
    );
  }
}
