
import 'dart:developer';

import 'package:chat_app/Modal/User_modal.dart';
import 'package:chat_app/services/Cloud_fireStore/Cloud_fireStore_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService
{
  GoogleAuthService._();
  static GoogleAuthService  googleAuthService = GoogleAuthService._();
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle()
  async {
    try
    {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =await googleSignInAccount!.authentication;
      AuthCredential credential =GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      UserModal user = UserModal(name:userCredential.user!.displayName.toString(),
          email: userCredential.user!.email.toString(),
          phone: userCredential.user!.phoneNumber.toString(),
          img: userCredential.user!.photoURL.toString(),
          token: '---------');
      CloudFireStoreService.cloudFireStoreService
          .insertUserIntoFireStore(user);
      log(userCredential.user!.email.toString());
      log(userCredential.user!.photoURL.toString());
    }
    catch(e)
    {
      Get.snackbar("Google sign Failed!", e.toString());
      log(e.toString());
    }
  }

  Future<void> googleSignOut()
  async {
    await googleSignIn.signOut();
  }
}