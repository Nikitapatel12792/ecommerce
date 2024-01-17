import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/chat_screen/component/chat_bubble.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/chat_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendname}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Column(
        children: [
          Obx(()=>
            controller.isloading.value?
            Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),): Expanded(
                child:StreamBuilder(
                  stream: FirestoreService.getchatmessage(controller.chatDocId.toString()),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
                    }
                    else if(snapshot.data!.docs.isEmpty){
                      return "Send a message".text.color(darkFontGrey).make();
                    }
                    else{
                     return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data=snapshot.data!.docs[index];

                         return Align(
                           alignment: data['uid']== currentUser?.uid? Alignment.centerRight:Alignment.centerLeft,
                             child: senderbubble(data));
                        }).toList()
                      );
                    }
                  },
                )

            ),
          ),
          10.heightBox,
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: controller.messagecontroller,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfieldGrey
                    )
                  ),
                  focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color: textfieldGrey
                      )
                  ) ,
                  hintText: "Type a message..."
                ),
              )),
              IconButton(onPressed: (){
                controller.sendmessage(controller.messagecontroller.text);
                controller.messagecontroller.clear();

              }, icon: Icon(Icons.send,color: redColor,))
            ],
          ).box.padding(EdgeInsets.all(8)).make()
        ],
      ).box.padding(EdgeInsets.all(15)).margin(EdgeInsets.only(bottom: 8)).make(),
    );
  }
}