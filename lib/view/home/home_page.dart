import 'package:animated_botton_navigation/animated_botton_navigation.dart';
import 'package:chat_app/Controller/chat_controller.dart';
import 'package:chat_app/Modal/User_modal.dart';
import 'package:chat_app/Utils/global.dart';
import 'package:chat_app/services/Cloud_fireStore/Cloud_fireStore_Service.dart';
import 'package:chat_app/services/Notification/notification.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/services/google_services/google_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
          child: FutureBuilder(
        builder: (context, snapshot) {
          var data = snapshot.data!.data();
          print(data);
          UserModal userModal = UserModal.fromMap(data!);

          if (snapshot.hasError) {
            return const Center(child: Text("Loading...."));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //   New group,new broadcast, linked devices, starred messages,payments,settings,updates,communities,calls,ai,

          return Column(
            // mainAxisAlignment: MainAxisAlignment,
            children: [
              SizedBox(
                height: height * 0.06,
              ),
              CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage("${userModal.img}"),
              ),
              Text(
                '${userModal.email}',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(color: Colors.black,),
                    // ,settings,updates,communities,calls,ai
                    buildRow(width,"New Group",Icons.group_add_outlined),
                    buildRow(width,"New Broadcast",Icons.broadcast_on_personal_outlined),
                    buildRow(width,"Linked Devices",Icons.dataset_linked_outlined),
                    buildRow(width,"Starred Messages",Icons.message),
                    buildRow(width,"Payment",Icons.payment_outlined),
                    buildRow(width,"Settings",Icons.settings),
                    buildRow(width,"Updates",Icons.update),
                    buildRow(width,"Communities",Icons.group_remove),
                    buildRow(width,"Calls",Icons.add_ic_call),

                  ],
                ),
              )
            ],
          );
        },
        future: CloudFireStoreService.cloudFireStoreService
            .readDataFroCurrantUserFromFireStore(),
      )),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/imog1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: CloudFireStoreService.cloudFireStoreService
              .readAllDataFroCurrantUserFromFireStore(),
          builder: (context, snapshot) {
            List data = snapshot.data!.docs;
            List<UserModal> userList = [];

            for (var user in data) {
              userList.add(
                UserModal.fromMap(
                  user.data(),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Loading....."),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chat App",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w700,
                            color: mainColor),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.qr_code_outlined,
                            size: 27,
                            color: mainColor,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Icon(Icons.camera_alt_outlined,
                              size: 27, color: mainColor),
                          IconButton(
                              onPressed: () async {
                                await LocalNotificationService
                                    .notificationService
                                    .showPeriodicNotification();
                              },
                              icon: Icon(
                                Icons.notification_add_outlined,
                                color: mainColor, size: 27,
                                // color: Colors.black,
                              )),
                        ],
                      ),
                      // Icon(Icons.),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'search',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                BorderSide(color: Colors.black54, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3 - 0.5),
                          ),
                          suffixIcon: Icon(
                            Icons.search, color: mainColor, size: 25,
                            // color: Colors.black,
                          ),
                          // icon: IconButton(onPressed: () async {
                          //  await LocalNotificationService.notificationService.showPeriodicNotification();
                          // }, icon: Icon(Icons.notification_add_outlined,color: Colors.white,)),
                          hoverColor: Colors.black,
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    // ListTile(
                    //   trailing: Icon(Icons.search),
                    // ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      height: height * 0.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          ...List.generate(
                            userList.length,
                            (index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    chatController.getReceiver(
                                      userList[index].name!,
                                      userList[index].email!,
                                      userList[index].img!,
                                    );
                                    Get.toNamed('/chat');
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage("${userList[index].img}"),
                                  ),
                                  title: Text(
                                    '${userList[index].name}',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    '${userList[index].email}',
                                    style: TextStyle(
                                      color: mainColor,
                                      // color: Colors.black,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black12,
                                  endIndent: 15,
                                  indent: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigation(
        selectedColor: chatController.changeColor(),
        unselectedColor: Colors.white,
        height: 55,
        backgroundColor: mainColor,
        // bottonNavigationDecoration: BoxDecoration(shape: BoxShape.circle),
        indicatorSpaceBotton: 20, 
        iconSize: 30,
        icons: const [
          Icons.home,
          Icons.update,
          Icons.group,
          Icons.call_rounded,
          Icons.person,
        ],
        currentIndex: chatController.currentIndexValue,
        onTapChange: (index) {
          chatController.indexChange(index);

          print(index);
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

  Widget buildRow(double width, String text,IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(icon,color: Colors.black,size: 28,),
          SizedBox(
            width: width * 0.05,
          ),
          Text(text,style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}
