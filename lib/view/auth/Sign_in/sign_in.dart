import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Utils/global.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/services/google_services/google_services.dart';
import 'package:chat_app/view/auth/Sign_up/sign_up.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 1,
                  child: ClipPath(
                    clipper: DirectionalWaveClipper(),
                    child: Container(
                      color: mainColor,
                      height: height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello! lets join with us',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          String.fromEnvironment('font1.otf'),
                                      fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: height * 0.05,),
                TextField(
                  controller: controller.txtEmail,
                  decoration: InputDecoration(
                      label: Text('Email'),
                      hintText: 'abc@gmail.com',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: controller.txtPassword,
                    decoration: InputDecoration(
                        label: Text('Password'),
                        hintText: '123455',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ))),
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),

                InkWell(
                  onTap: () async {
                    String response = await AuthService.authService
                        .signInWithEmailAndPassword(controller.txtEmail.text,
                            controller.txtPassword.text);
                    User? user = AuthService.authService.getCurrentUser();
                    if (user != null && response == "success") {
                      Get.offAndToNamed('/Home');
                    } else {
                      Get.snackbar('Sign In Failed', response);
                    }
                  },
                  child: Container(
                      height: height * 0.06,
                      width: double.infinity,
                      // color: mainColor,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: mainColor),
                      child: Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ))),
                ),
                // SizedBox(
                //   width: width * 1,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: mainColor,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12))),
                //     onPressed: () async {
                //       // user null
                //       String response = await AuthService.authService
                //           .signInWithEmailAndPassword(controller.txtEmail.text,
                //               controller.txtPassword.text);
                //       User? user = AuthService.authService.getCurrentUser();
                //       if (user != null && response == "success") {
                //         Get.offAndToNamed('/Home');
                //       } else {
                //         Get.snackbar('Sign In Failed', response);
                //       }
                //     },
                //     child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400),),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     // user null
                //     String response = await AuthService.authService
                //         .signInWithEmailAndPassword(
                //             controller.txtEmail.text, controller.txtPassword.text);
                //     User? user = AuthService.authService.getCurrentUser();
                //     if (user != null && response == "success") {
                //       Get.offAndToNamed('/Home');
                //     } else {
                //       Get.snackbar('Sign In Failed', response);
                //     }
                //   },
                //   child: Text('Sign In'),
                // ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offAndToNamed('/signup');
                      },
                      child: Text("Dont have Account ? Sign Up"),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SignInButton(
                  Buttons.google,
                  onPressed: () {
                    GoogleAuthService.googleAuthService.signInWithGoogle();
                    User? user = AuthService.authService.getCurrentUser();
                    if (user != null) {
                      Get.offAndToNamed('/home');
                    }
                  },
                  padding: EdgeInsets.all(6),
                  elevation: 13,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
