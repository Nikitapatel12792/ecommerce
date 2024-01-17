import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/order_screen/oreder_detail.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getallorders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          var data=snapshot.data?.docs[0];
          print(data?['order_by_address']);
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),));
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No order yet!".text.color(darkFontGrey).makeCentered();
          }
          else{
            var data=snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      Get.to(Ordersdetail(data: data[index],));
                    },
                    leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                    title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_forward_ios,color: darkFontGrey,),
                    ),
                  );
                });
          }
        }
      ),
    );
  }
}
