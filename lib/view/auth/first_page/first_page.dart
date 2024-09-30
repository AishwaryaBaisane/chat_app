import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Utils/global.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:chat_app/view/auth/Sign_up/sign_up.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.2,
              width: width * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/chat13.png'),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Container(
              height: height * 0.59,
              width: double.infinity,
              // color: mainColor,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Text(
                    "Lets connect \nwith each other",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Ready to connect? Start messaging now.",
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  SizedBox(
                    height: height * 0.16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(SignIn());
                        },
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SignUp());
                        },
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(SignUp());
                      //   },
                      //   child: Center(
                      //       child: Text(
                      //         'Sign Up',
                      //         style: TextStyle(color: Colors.white, fontSize: 30),
                      //       )),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
