import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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

              },
              child: Text("Alrady have Account ? Sign Up"),
            ),
            ElevatedButton(
              onPressed: () {
                AuthService.authService.createAccountWithEmailAndPassword(
                    controller.txtEmail.text, controller.txtPassword.text);
                Get.back();
                controller.txtEmail.clear();
                controller.txtPassword.clear();
                // Get.offAndToNamed('/Home');
              },
              child: Text('Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}
