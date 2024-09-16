import 'package:chat_app/Modal/User_modal.dart';
import 'package:chat_app/Modal/chat_modal.dart';
import 'package:chat_app/services/auth_aervices/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService = CloudFireStoreService
      ._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModal user) {
    fireStore.collection('user').doc(user.email).set({
      'email': user.email,
      'name': user.name,
      'token': user.token,
      'phone': user.phone,
      'img': user.img,
    });
  }

  Future<DocumentSnapshot<
      Map<String, dynamic>>> readDataFroCurrantUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("user").doc(user!.email).get();
  }

  Future<QuerySnapshot<
      Map<String, dynamic>>> readAllDataFroCurrantUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("user").where(
        "email", isNotEqualTo: user!.email).get();
  }


  // add chat in fire store
  void addChatInFireStore(ChatModal chat) {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender,receiver];
    // fireStore.collection("chatroom").doc().collection("chat").add(
    //     chat.toMap(chat))
  }
}