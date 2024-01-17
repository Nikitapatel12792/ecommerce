
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/chat_screen/chat_screen.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getallmessage(),
          builder:   (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No Messages yet!".text.color(darkFontGrey).makeCentered();
            }
            else{
              var data=snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context,index){
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Get.to(()=>ChatScreen(),arguments: [data[index]['friend_name'].toString(),
                                    data[index]['toId'].toString()]);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(Icons.person,color: whiteColor,),
                                ),
                                title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                subtitle: "${data[index]['last_message']}".text.make(),

                              ),
                            );

                      }),
                    )
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
