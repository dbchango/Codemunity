

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance; 
  
  // sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<User> get user{
    return _auth.authStateChanges();
  }

  // sign in with e-mail & password
  Future signInWithEmailAndPassword(String email, String password) async { 
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future createUserWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out 
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}