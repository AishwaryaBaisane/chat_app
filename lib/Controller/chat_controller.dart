import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  String receiverImg = "";
  RxString Image = "".obs;
  int currentIndexValue = 0;
  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpDateMessage = TextEditingController();

  void getReceiver(String name, String email,String img)
  {
    receiverEmail.value = email;
    receiverName.value = name;
    receiverImg = img;
  }
  void getImage(String url)
  {
    Image.value = url;
  }
  void indexChange(int index)
  {

    currentIndexValue = index;
    print('${currentIndexValue}');

  }
  Color changeColor()
  {
    return const Color(0xff68d4d1);
  }

//     tencent_cloud_chat_uikit: ^2.7.1
//   chat_ui_kit: ^1.4.0
}