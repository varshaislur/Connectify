import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/components/comment.dart';
import 'package:connectify/components/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class WallPost extends StatefulWidget {
  final String user;
  final String message;
  final String postId;
  final List likes;
  const WallPost({super.key,required this.message,required this.user,required this.postId,required this.likes});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  TextEditingController commentcontroller=TextEditingController();
  User currentUser= FirebaseAuth.instance.currentUser!;
  bool isLiked=false;
  var commentCount=0;
  @override
  void initState() {
    // TODO: implement initState
    isLiked=widget.likes.contains(currentUser.email);
    super.initState();
  }
 // called when like button is pressed
  void likeFunction(){
    setState(() {
      isLiked=!isLiked;

    });
    //reference of the document to update likes
    DocumentReference postref = FirebaseFirestore.instance.collection("posts").doc(widget.postId)!;
    if(isLiked){
      //if post is liked, then add current user to likes of the post
      postref.update({
        "likes": FieldValue.arrayUnion([currentUser.email])
      });
    }
    else{
      //if post is unliked remove current user from likes
      postref.update({
        "likes":FieldValue.arrayRemove([currentUser.email])
      });

    }
  }
  //this function is called when comment is posted in dialog box
  void addComment() async{
   await FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").add({
     "commentMessage":commentcontroller.text.toString(),
     "commentedBy":currentUser.email.toString(),
     "commentTime":Timestamp.now()
   });
   setState((){
     Future<int> commentCount = FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").snapshots().length ;
   });
   Navigator.pop(context);
   commentcontroller.clear();

  }
  //this function is to pop up the dialog box when the comment icon is clicked
  void CommentDialog() async{
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Enter your comment"),
      content: TextField(
        controller:commentcontroller,




      ),
      actions: [
        ElevatedButton(onPressed: addComment, child: Text("POST")),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          commentcontroller.clear();
        }, child: Text("CANCEL")),

      ],

    ));
  }

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
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
      // child: Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Colors.white,
        //     border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color.fromRGBO(196, 135, 198, 1),
        //         blurRadius: 20,
        //         offset: Offset(0, 10),
        //       )
        //     ]
        // ),
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
                  color: Colors.black,

                ),
                child: Icon(Icons.person,color: Colors.white.withOpacity(0.5),),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.message,
                      maxLines: 10,
                      softWrap: true,
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user,style: TextStyle(
                      color: Colors.grey,
                    ),),
                  ),
                 Column(
                   children: [
                     Text("COMMENTS",style: TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold,
                     ),),
                     StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").snapshots(),
                         builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator());
                          }
                          else if(snapshot.hasError){
                            return Text(snapshot.error.toString());
                          }
                          else{
                            // Update commentsCount based on the length of snapshot data
                              commentCount = snapshot.data!.docs.length;



                            return ListView(
                              shrinkWrap: true,

                              children: snapshot.data!.docs.map((doc){
                                //get the comment from firestore -code by varsha
                                final commentData= doc.data() as Map<String,dynamic>;
                                //display it on the ui
                                return Comment(commentMessage: commentData['commentMessage'], commentedBy: commentData['commentedBy']);
                              }).toList(),

                            );
                          }

                         }),
                   ],
                 )
              
                ],
              ),
            ),
            Column(children:[
              LikeButton(isLiked:widget.likes.contains(currentUser.email), onTap:likeFunction),
              Text(widget.likes.length.toString(),style: TextStyle(
                color: Colors.white,
              ),),
              IconButton(
                icon:Icon(Icons.comment),
                onPressed: CommentDialog,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(commentCount.toString(),style: TextStyle(
                  color: Colors.white,
                ),),
              ),

            ]),
            //like counter

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
