import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:chat_app/view/auth/Sign_up/sign_up.dart';
import 'package:chat_app/view/auth/auth_manager/auth_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const AuthManager(),),
        GetPage(name: '/signIn', page: () => const SignIn(),),
        GetPage(name: '/signup', page: () => const SignUp(),),
        GetPage(name: '/Home', page: () => const HomePage(),),
      ],
    );
  }
}
