import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
//notes
//remember to validate confirm password field

//and obscure password

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  TextEditingController confirm_controller=TextEditingController();




  Future<void> register() async{
    //loading indicator
    showDialog(context: context, builder: (context){
      return Center(child:CircularProgressIndicator(),
      );});


    try {
      //create the user
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim());
      // after creating the user, create a document storing username and bio of user in Users collection
      //email is the unique key
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set(
          {
            "user_email":userCredential.user!.email.toString(),
            "username":email_controller.text.split("@")[0],
            "user_bio":"Hey there, I am using connectify",


          });
      //pop loading
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    } on FirebaseException catch (e){
      //pop loading
      Navigator.pop(context);
      ErrorMessage(e.message!);
    }
  }
  void ErrorMessage(String errormessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(errormessage),
          // content: const SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Text('This is a demo alert dialog.'),
          //       Text('Would you like to approve of this message?'),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(


      // backgroundColor: Colors.black,

      // appBar: AppBar(
      //   backgroundColor: Colors.black
      //   ,
      //   title: Text("Login",style:TextStyle(
      //     color: Colors.white,
      //     fontWeight: FontWeight.bold,
      //   )),
      //
      // ),
        body:SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width:MediaQuery.of(context).size.width,

              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child:Stack(
                        children: [
                          Positioned(child: Container(
                            height:270,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/animations/background.png")
                                )
                            ),
                          )),
                          Positioned(
                              child: Container(
                                height:300,
                                width:500,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("assets/animations/background-3.png")
                                    )
                                ),
                              ))
                        ],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Text("SignUp",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Enter email:",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                  Padding(padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: TextField(

                        controller:email_controller,
                        decoration: InputDecoration(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Enter password:",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                  Padding(padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: TextField(

                        controller:password_controller,
                        decoration: InputDecoration(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Confirm password:",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                  Padding(padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: TextField(

                        controller:confirm_controller,
                        decoration: InputDecoration(
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text("Already have an account?"),
                        GestureDetector(child: Text("Login",style: TextStyle(
                          color:Colors.blueAccent,
                          fontWeight: FontWeight.bold,

                        ),), onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: GestureDetector(
                        onTap:(){
                          register();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(75, 0, 130, 1),
                          ),

                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("SIGN UP",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
