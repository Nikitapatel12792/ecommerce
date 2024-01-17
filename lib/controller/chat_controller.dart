import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  @override
  void onInit() {
    getchatid();
    // TODO: implement onInit
    super.onInit();
  }
  var isloading=false.obs;
  var chats= firestore.collection(chatCollection);
  var friendname=Get.arguments[0];
  var friendid=Get.arguments[1];
  var sendername=Get.find<HomeController>().username;
  var currentid=currentUser?.uid;
  var messagecontroller=TextEditingController();
  dynamic chatDocId;
  getchatid()async{
    isloading(true);
    await chats.where('users',isEqualTo: {
      friendid:null,
      currentid:null,
    })..limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;
      }
      else{
        chats.add(
          {
            'created_on':null,
            'last_message': "",
            'users':{friendid:null,currentid:null},
            'toId':'',
            'fromId':'',
            'friend_name':friendname,
            'sender_name':sendername
          }).then((value) {
            chatDocId=value.id;
        });
      }
    });
    isloading(false);
  }

  sendmessage(String msg)async{
    print(msg);
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_message': msg,
        'toId':friendid,
        'fromId':currentid,
      });
      chats.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg': msg,
        'uid':currentid,
      });
    }

}
}