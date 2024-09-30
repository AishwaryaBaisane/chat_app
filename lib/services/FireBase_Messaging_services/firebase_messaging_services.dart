import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseMessagingServices
{
  FirebaseMessagingServices._();
  static FirebaseMessagingServices fm = FirebaseMessagingServices._();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestPermission()
  async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus!=AuthorizationStatus.authorized)
      {
        await requestPermission();
      }
    else if(settings.authorizationStatus==AuthorizationStatus.authorized)
    {
        await Get.snackbar("Hii there", "New Feather Alert !! \n Go And Check !!");
    }
  }

  Future<void> getDeviceToken()
  async {
    String? token = await messaging.getToken();
    log(token!);
  }
}