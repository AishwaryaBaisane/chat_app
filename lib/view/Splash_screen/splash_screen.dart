import 'package:chat_app/view/auth/first_page/first_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () {
            Get.to(FirstPage());
          },
          child: Image(
            image: AssetImage('assets/img/logo.png'),height: height * 0.5,
            width: width * 0.7,
          ),
        ),
      ),
    );
  }
}
