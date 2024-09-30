import 'package:chat_app/Controller/chat_controller.dart';
import 'package:chat_app/Modal/chat_modal.dart';
import 'package:chat_app/Utils/global.dart';
import 'package:chat_app/services/Cloud_fireStore/Cloud_fireStore_Service.dart';
import 'package:chat_app/services/Notification/notification.dart';
import 'package:chat_app/services/Storage_Service/Storage_Service.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var chatController = Get.put(ChatController());
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(chatController.receiverName.value),
        // ),
        body: Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/imog1.jpg'), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
            color: mainColor,
            height: 28,
          ),
          Container(
            height: height * 0.065,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.01,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(HomePage());
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        chatController.receiverImg.toString(),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      chatController.receiverName.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.video_call_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: width * 0.06,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: CloudFireStoreService.cloudFireStoreService
                  .readChatFromFireStore(chatController.receiverEmail.value),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Loading....."));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List data = snapshot.data!.docs;
                List<ChatModal> chatList = [];
                List<String> docList = [];
                for (QueryDocumentSnapshot snap in data) {
                  docList.add(snap.id);
                  chatList.add(ChatModal.fromMap(snap.data() as Map));
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    chatList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        if (chatList[index].sender ==
                            AuthService.authService.getCurrentUser()!.email) {
                          chatController.txtUpDateMessage =
                              TextEditingController(
                                  text: chatList[index].message);
                          print("dftgyhu");
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Update"),
                                content: TextField(
                                  controller: chatController.txtUpDateMessage,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      String dcId = docList[index];
                                      CloudFireStoreService
                                          .cloudFireStoreService
                                          .updateChatFromFireStore(
                                              chatController
                                                  .receiverEmail.value,
                                              dcId,
                                              chatController
                                                  .txtUpDateMessage.text);
                                      Get.back();
                                    },
                                    child: Text("Update"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      onDoubleTap: () {
                        CloudFireStoreService.cloudFireStoreService.removeChat(
                            chatController.receiverEmail.value, docList[index]);
                      },
                      child: Container(
                        alignment: (chatList[index].sender ==
                                AuthService.authService
                                    .getCurrentUser()!
                                    .email!)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: height * 0.04,
                            decoration: BoxDecoration(
                              color: (chatList[index].sender ==
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email!)
                                  ? mainColor.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: (chatList[index].sender ==
                                      AuthService.authService
                                          .getCurrentUser()!
                                          .email!)
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                            ),
                            child: (chatList[index].image!.isEmpty &&
                                    chatList[index].image == "")
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 5, right: 10),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: chatList[index].message!,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          TextSpan(
                                              text:
                                                  "\t\t${(chatList[index].time!.toDate().hour > 9 && chatList[index].time!.toDate().hour < 24) ? (chatList[index].time!.toDate().hour % 12) : '0${(chatList[index].time!.toDate().hour)}'} : ${(chatList[index].time!.toDate().minute > 9) ? (chatList[index].time!.toDate().minute) : '0${(chatList[index].time!.toDate().minute)}'} ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white)),
                                          TextSpan(
                                              text: (chatList[index]
                                                          .time!
                                                          .toDate()
                                                          .hour >
                                                      12)
                                                  ? 'PM'
                                                  : 'AM',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: height * 0.2,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              chatList[index].image!),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.white,
                controller: chatController.txtMessage,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.white, width: 3 - 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3 - 0.5)),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              String url =
                                  await StorageService.service.uploadImage();
                              chatController.getImage(url);
                            },
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 15,
                                ),
                              ],
                            )),
                        IconButton(
                          onPressed: () async {
                            ChatModal chat = ChatModal(
                                image: chatController.Image.value,
                                sender: AuthService.authService
                                    .getCurrentUser()!
                                    .email,
                                receiver: chatController.receiverEmail.value,
                                message: chatController.txtMessage.text,
                                time: Timestamp.now());

                            await CloudFireStoreService.cloudFireStoreService
                                .addChatInFireStore(chat);
                            await LocalNotificationService.notificationService
                                .showNotification(
                                    AuthService.authService
                                        .getCurrentUser()!
                                        .email!,
                                    chatController.txtMessage.text);
                            chatController.txtMessage.clear();
                            chatController.txtUpDateMessage.clear();
                            chatController.getImage("");
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 15,
                              ),
                            ],
                            // textDirection: ,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

// Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Text(
//                                   chatList[index].message! + "${(DateTime.now().hour > 9 && DateTime.now().hour < 24) ? (DateTime.now().hour % 12) : '0${(DateTime.now().hour)}'} : ${(DateTime.now().minute > 9) ? (DateTime.now().minute) : '0${(DateTime.now().minute)}'} : ${(DateTime.now().second > 9) ? (DateTime.now().second) : '0${(DateTime.now().second)}'}'",
//                                   style: TextStyle(
//                                       color: (chatList[index].sender ==
//                                               AuthService.authService
//                                                   .getCurrentUser()!
//                                                   .email! )
//                                           ? Colors.white
//                                           : mainColor,
//                                       fontSize: 23),
//                                 ),
//                               ),
