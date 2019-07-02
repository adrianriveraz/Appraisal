//class handles the authenticatiom users with firebase
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//interface for auth
abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password) ;
  Future<String> currentUser();
  Future<void> signOut() ;
}

class Auth implements BaseAuth{
  
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    FirebaseUser fu = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return fu.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    FirebaseUser fu = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return fu.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser fu = await FirebaseAuth.instance.currentUser();
    return fu?.uid;
  }

  Future<void> signOut() async{
    return FirebaseAuth.instance.signOut();
  }
  

}