import 'package:firebase_auth/firebase_auth.dart';

class UserFunctions{
  //user signed out
  Future<void> usersignout() async{
    await FirebaseAuth.instance.signOut();
  }



}