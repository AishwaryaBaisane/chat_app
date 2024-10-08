import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ACCOUNT CREATE - SIGN-UP
  Future<String> createAccountWithEmailAndPassword(String email, String password)
  async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "success";
    }catch(e)
    {
      return e.toString();
    }

  }

//  LOGIN SIGN IN

  Future<String> signInWithEmailAndPassword(String email, String password) async {
   try
       {
         await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
         return "success";
       }
       catch(e)
    {
      return e.toString();
    }
  }

//   SIGN OUT
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      log("email: ${user.email}");
    }
    return user;
  }

}
