import 'package:connectify/screens/homepage.dart';
import 'package:connectify/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  void handleSignin() async{
    //loading indicator
    showDialog(context: context, builder: (context){
      return Center(child:CircularProgressIndicator(),
      );
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim());
      //pop loading
       Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    } on FirebaseException catch(e){
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
    final devicewidth=MediaQuery.of(context).size.width;
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Login",
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text("Don't have an account?"),
                      GestureDetector(child: Text("Sign Up",style: TextStyle(
                        color:Colors.blueAccent,
                        fontWeight: FontWeight.bold,

                      ),), onTap:(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: GestureDetector(
                      onTap:(){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        handleSignin();
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
                            child: Text("LOGIN",style: TextStyle(
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
