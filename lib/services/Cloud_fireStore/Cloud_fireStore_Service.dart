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
      'time' : DateTime.now(),
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
  Future<void> addChatInFireStore(ChatModal chat)  async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender,receiver];
    doc.sort();
    String docId = doc.join('_');
    await fireStore.collection("chatroom").doc(docId).collection("chat").add(chat.toMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(String receiver)
  {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender,receiver];
    doc.sort();
    String docId = doc.join("_");
    return fireStore.collection("chatroom").doc(docId).collection("chat").orderBy("time",descending: false).snapshots();
  }
  Future<void> updateChatFromFireStore(String receiver, String dcId, String message) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

   await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({'message': message});
  }

  Future<void> removeChat(String receiver, String dcId)
  async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .delete();
  }
}