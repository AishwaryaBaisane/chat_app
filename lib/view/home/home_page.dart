import 'dart:ui';

import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/services/google_services/google_services.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           await AuthService.authService.signOutUser();
      //           GoogleAuthService.googleAuthService.googleSignOut();
      //           User? user = AuthService.authService.getCurrentUser();
      //           if (user == null) {
      //             Get.offAndToNamed('/signIn');
      //           }
      //         },
      //         icon: Icon(Icons.logout))
      //   ],
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black38,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: Image(
                image: AssetImage('assets/img/home2.jpg'),
              ),
            ).asGlass(),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Welcome \n To \n Chat App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(7, 7),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          await AuthService.authService.signOutUser();
          GoogleAuthService.googleAuthService.googleSignOut();
          User? user = AuthService.authService.getCurrentUser();
          if (user == null) {
            Get.offAndToNamed('/signIn');
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
