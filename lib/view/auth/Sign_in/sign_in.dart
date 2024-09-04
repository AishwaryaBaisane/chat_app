import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/auth/Sign_up/sign_up.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtEmail,
              decoration: InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.offAndToNamed('/signup');
              },
              child: Text("Dont have Account ? Sign Up"),
            ),
            ElevatedButton(
              onPressed: () async {
                // user null
              String response =  await AuthService.authService.signInWithEmailAndPassword(
                    controller.txtEmail.text, controller.txtPassword.text);
                User? user = AuthService.authService.getCurrentUser();
                if(user!=null && response =="success")
                  {
                    Get.offAndToNamed('/Home');
                  }
                else
                {
                 Get.snackbar('Sign In Failed',response);
                }
              },
              child: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }
}
