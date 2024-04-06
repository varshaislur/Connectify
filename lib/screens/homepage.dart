import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/components/custom_drawer.dart';
import 'package:connectify/components/glass_box.dart';
import 'package:connectify/components/wall_post.dart';
import 'package:connectify/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController postmessage_controller=TextEditingController();
  Future<void> signout() async {

    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  User currentUser=FirebaseAuth.instance.currentUser!;

  void postmessage () async{
   //post if textfield is not empty
    if(postmessage_controller.text.isNotEmpty){
      await FirebaseFirestore.instance.collection("posts").add({
        "user":currentUser.email.toString(),
        "message":postmessage_controller.text.trim(),
        "time":Timestamp.now(),
        "likes":[],
      });
      postmessage_controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
        backgroundColor: Colors.black,
      // backgroundColor: Color.fromRGBO	(	48, 25, 52,1),
      //   backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text("Connectify",style:TextStyle(
          fontWeight: FontWeight.bold,
        )),
        actions: [
          IconButton(onPressed: (){
            signout();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/animations/background-3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [

            Expanded(
              child: StreamBuilder(stream: FirebaseFirestore.instance.collection("posts").snapshots(), builder: (context,snapshot)
              {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount:snapshot.data!.docs.length ,
                      itemBuilder: (context,index){
                    final post=snapshot.data!.docs[index];
                    print(post.runtimeType);
                    print(snapshot.data);
                    print(snapshot.data!.docs);
                        return WallPost(message: post["message"], user: post["user"],postId: post.id.toString(),likes: List<String>.from(post["likes"] ?? []),
                        );

                  }

                  );

                }
                // else if(snapshot.hasError){
                //   print(snapshot.error);
                //
                // }
                else{
                  return CircularProgressIndicator();
                }

              }),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    width:MediaQuery.of(context).size.width-70,


                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                        color: Colors.white,
                        // border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromRGBO(196, 135, 198, 1),
                        //     blurRadius: 20,
                        //     offset: Offset(0, 10),
                        //   )
                        // ]
                    ),
                    child: TextField(


                      controller:postmessage_controller,
                      decoration: InputDecoration(
                        hintText: "Post a message",
                          enabledBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: IconButton(onPressed: (){
                    postmessage();
                  }, icon:Icon( Icons.send,size: 30, color: Colors.white,)),
                ),

              ]

            ),
            Text("Logged in user: "+currentUser.email.toString()),

          ],
        ),
      )
    );
  }
}
