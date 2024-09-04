import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('Home Page'),
    actions: [
      IconButton(onPressed: () async {
       await AuthService.authService.signOutUser();
        User? user = AuthService.authService.getCurrentUser();
        if(user==null)
          {
            Get.offAndToNamed('/signIn');
          }

      }, icon: Icon(Icons.logout))
    ],),

    );
  }
}
