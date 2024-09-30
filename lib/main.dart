import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/FireBase_Messaging_services/firebase_messaging_services.dart';
import 'package:chat_app/view/auth/Sign_in/sign_in.dart';
import 'package:chat_app/view/auth/Sign_up/sign_up.dart';
import 'package:chat_app/view/auth/auth_manager/auth_manager.dart';
import 'package:chat_app/view/auth/first_page/first_page.dart';
import 'package:chat_app/view/home/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/Notification/notification.dart';
import 'view/home/home_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation(timeZoneName));
  await LocalNotificationService.notificationService.initNotificationService();
  // await FirebaseMessagingServices.fm.requestPermission();
  // await FirebaseMessagingServices.fm.getDeviceToken();
  runApp(const MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
//
// class _MyAppState extends State<MyApp> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     log("\n\ninterstate called !!\n\n");
//   }
//
//   @override
//   void deactivate() {
//     // TODO: implement deactivate
//     log("\n\ndispose called !!\n\n");
//     super.deactivate();
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     log("\n\ndispose called !!\n\n");
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       getPages: [
//         GetPage(
//           name: '/',
//           page: () => const AuthManager(),
//         ),
//         GetPage(
//           name: '/signIn',
//           page: () => const SignIn(),
//         ),
//         GetPage(
//           name: '/signup',
//           page: () => const SignUp(),
//         ),
//         GetPage(
//           name: '/Home',
//           page: () => const HomePage(),
//         ),
//         GetPage(
//           name: '/chat',
//           page: () => const ChatPage(),
//         ),
//       ],
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const FirstPage(),
        ),
        GetPage(
          name: '/signIn',
          page: () => const SignIn(),
            transition:Transition.cupertino
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUp(),
            transition:Transition.cupertino
        ),
        GetPage(
          name: '/Home',
          page: () => const HomePage(),
            transition:Transition.size
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatPage(),
          transition:Transition.size
        ),
      ],
    );
  }
}
