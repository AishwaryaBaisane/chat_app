import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Modal/User_modal.dart';
import 'package:chat_app/Utils/global.dart';
import 'package:chat_app/services/Cloud_fireStore/Cloud_fireStore_Service.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var controller = Get.put(AuthController());
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: mainColor,
      //   centerTitle: true,
      //   title: Text(
      //     'Sign Up',
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 1,
                    child: ClipPath(
                      clipper: SinCosineWaveClipper(),
                      child: Container(
                        color: mainColor,
                        height: height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome\nBack',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w400,
                                      // fontFamily: 'regular1',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hey! Good to see you again',
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
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: controller.txtName,
                    decoration: InputDecoration(
                      label: Text('Name'),
                      hintText: 'admin',
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  TextField(
                    controller: controller.txtPassword,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      hintText: '12345657',
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  TextField(
                    controller: controller.txtConfirmPassword,
                    decoration: InputDecoration(
                      label: Text('Conform password'),
                      hintText: '12345657',
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  TextField(
                    controller: controller.txtPhone,
                    decoration: InputDecoration(
                      label: Text('Phone'),
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  InkWell(
                    onTap: () async {
                      if (controller.txtPassword.text ==
                          controller.txtConfirmPassword.text) {
                        await AuthService.authService
                            .createAccountWithEmailAndPassword(
                          controller.txtEmail.text,
                          controller.txtPassword.text,
                        );
                        UserModal user = UserModal(
                            name: controller.txtName.text,
                            email: controller.txtEmail.text,
                            phone: controller.txtPhone.text,
                            img:
                                "data:image/jpeg;base64,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",
                            token: '---------');
                        CloudFireStoreService.cloudFireStoreService
                            .insertUserIntoFireStore(user);
                      Get.offAndToNamed('/Home');
                        controller.txtEmail.clear();
                        controller.txtPassword.clear();
                        controller.txtConfirmPassword.clear();
                        controller.txtName.clear();
                        controller.txtPhone.clear();
                      }
                      else
                        {
                          Get.snackbar("Incorrect Password!", "Check Password!!",backgroundColor: Colors.red,colorText: Colors.white);
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
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: width * 1,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: mainColor,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12))),
                  //     onPressed: () {
                  //       AuthService.authService.createAccountWithEmailAndPassword(
                  //           controller.txtEmail.text, controller.txtPassword.text);
                  //       Get.back();
                  //       controller.txtEmail.clear();
                  //       controller.txtPassword.clear();
                  //       // Get.offAndToNamed('/Home');
                  //     },
                  //     child: Text(
                  //       'Sign Up',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 25,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     AuthService.authService.createAccountWithEmailAndPassword(
                  //         controller.txtEmail.text, controller.txtPassword.text);
                  //     Get.back();
                  //     controller.txtEmail.clear();
                  //     controller.txtPassword.clear();
                  //     // Get.offAndToNamed('/Home');
                  //   },
                  //   child: Text('Sign Up'),
                  // ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed('/signIn');
        
                    },
                    child: Text(
                      "Alrady have Account ? Sign In",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.,
//             // mainAxisSize: MainAxisSize.,
//             children: [
//               // Text('Welcome\nBack'),
//               SizedBox(
//                 height: height * 0.13,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Welcome\nBack',
//                         style: TextStyle(
//                             fontSize: 60,
//                             fontWeight: FontWeight.w900,
//                             fontFamily: 'regular1'),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hey! Good to see you again',
//                         style: TextStyle(
//                             fontFamily: String.fromEnvironment('font1.otf'),
//                             fontSize: 20),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: height * 0.08,
//               ),
//               TextField(
//                 controller: controller.txtName,
//                 decoration: InputDecoration(
//                     label: Text('Name'),
//                     hintText: 'admin',
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainColor),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: mainColor),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ))),
//               ),
//               TextField(
//                 controller: controller.txtEmail,
//                 decoration: InputDecoration(
//                   label: Text('Email'),
//                   hintText: 'abc@gmail.com',
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainColor),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainColor),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: controller.txtPassword,
//                 decoration: InputDecoration(
//                     label: Text('Password'),
//                     hintText: '12345657',
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainColor),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: mainColor),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ))),
//               ),
//
//               TextField(
//                 controller: controller.txtConfirmPassword,
//                 decoration: InputDecoration(
//                     label: Text('Conform password'),
//                     hintText: '12345657',
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainColor),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: mainColor),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ))),
//               ),
//               TextField(
//                 controller: controller.txtPhone,
//                 decoration: InputDecoration(
//                     label: Text('Phone'),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainColor),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: mainColor),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ))),
//               ),
//               InkWell(
//                 onTap: () async {
//                   if (controller.txtPassword.text ==
//                       controller.txtConfirmPassword.text) {
//                     await AuthService.authService
//                         .createAccountWithEmailAndPassword(
//                       controller.txtEmail.text,
//                       controller.txtPassword.text,
//                     );
//                     UserModal user = UserModal(name: controller.txtName.text,
//                         email: controller.txtEmail.text,
//                         phone: controller.txtPhone.text,
//                         img: "data:image/jpeg;base64,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",
//                         token: '---------');
//                     CloudFireStoreService.cloudFireStoreService
//                         .insertUserIntoFireStore(user);
//                     Get.back();
//                     controller.txtEmail.clear();
//                     controller.txtPassword.clear();
//                     controller.txtConfirmPassword.clear();
//                     controller.txtName.clear();
//                     controller.txtPhone.clear();
//                   }
//                 },
//                 child: Container(
//                     height: height * 0.06,
//                     width: double.infinity,
//                     // color: mainColor,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(35),
//                         color: mainColor),
//                     child: Center(
//                         child: Text(
//                           'Sign Up',
//                           style: TextStyle(color: Colors.white, fontSize: 30),
//                         ))),
//               ),
//               // SizedBox(
//               //   width: width * 1,
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(
//               //         backgroundColor: mainColor,
//               //         shape: RoundedRectangleBorder(
//               //             borderRadius: BorderRadius.circular(12))),
//               //     onPressed: () {
//               //       AuthService.authService.createAccountWithEmailAndPassword(
//               //           controller.txtEmail.text, controller.txtPassword.text);
//               //       Get.back();
//               //       controller.txtEmail.clear();
//               //       controller.txtPassword.clear();
//               //       // Get.offAndToNamed('/Home');
//               //     },
//               //     child: Text(
//               //       'Sign Up',
//               //       style: TextStyle(
//               //           color: Colors.white,
//               //           fontSize: 25,
//               //           fontWeight: FontWeight.w400),
//               //     ),
//               //   ),
//               // ),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     AuthService.authService.createAccountWithEmailAndPassword(
//               //         controller.txtEmail.text, controller.txtPassword.text);
//               //     Get.back();
//               //     controller.txtEmail.clear();
//               //     controller.txtPassword.clear();
//               //     // Get.offAndToNamed('/Home');
//               //   },
//               //   child: Text('Sign Up'),
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {},
//                     child: Text("Alrady have Account ? Sign In"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
