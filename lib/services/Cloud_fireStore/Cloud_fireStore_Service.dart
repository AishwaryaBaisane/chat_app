import 'package:chat_app/Modal/User_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService = CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModal user)
  {
    fireStore.collection('user').doc(user.email).set({
      'email':user.email,
      'name':user.name,
      'token':user.token,
      'phone':user.phone,
      'img':user.img,
    });
  }
}