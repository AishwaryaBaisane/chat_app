import 'dart:ui';

import 'package:chat_app/Modal/User_modal.dart';
import 'package:chat_app/services/Cloud_fireStore/Cloud_fireStore_Service.dart';
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
      appBar: AppBar(),
      drawer: Drawer(
          child: FutureBuilder(
        builder: (context, snapshot) {
          var data = snapshot.data!.data();
          print(data);
          UserModal userModal = UserModal.fromMap(data!);

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Row(
            children: [
              Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        Image(image: NetworkImage("${userModal.img}"),),
                        Text('${userModal.email}'),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
        future: CloudFireStoreService.cloudFireStoreService
            .readDataFroCurrantUserFromFireStore(),
      )),
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllDataFroCurrantUserFromFireStore(),
        builder: (context, snapshot) {
          List data = snapshot.data!.docs;
          List<UserModal> userList = [];

          for (var user in data) {
            userList.add(UserModal.fromMap(user.data()));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Center(
              child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/chat');
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${userList[index].img}"),
                  ),
                  title: Text('${userList[index].name}'),
                  subtitle: Text('${userList[index].email}'),
                ),
              );
            },
          ));
        },
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
//Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.black38,
//         child: Stack(
//           children: [
//             Opacity(
//               opacity: 0.2,
//               child: Image(
//                 image: AssetImage('assets/img/home2.jpg'),
//               ),
//             ).asGlass(),
//             Center(
//               child: Text(
//                 textAlign: TextAlign.center,
//                 "Welcome \n To \n Chat App",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 50,
//                   fontWeight: FontWeight.w700,
//                   shadows: [
//                     Shadow(
//                       color: Colors.black26,
//                       offset: Offset(7, 7),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
