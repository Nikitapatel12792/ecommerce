import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/cart_screen/shipping_screen.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(CartController());
    return Scaffold(
      bottomNavigationBar:   SizedBox(
          height: 60,
        child: ourbutton( title:"Proceed to shipping" ,color: redColor,textColor: whiteColor,
            onPress: (){
          Get.to(ShippingScreen());
            }),
      ),
      backgroundColor: Colors.white,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title:"Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ) ,
      body:StreamBuilder(
        stream: FirestoreService.getCart(currentUser?.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
              }
              else if(snapshot.data!.docs.isEmpty){
                return "No Product added to cart".text.color(darkFontGrey).makeCentered();
              }
              else{
                var data=snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot=data;
                return
                Column(
                  children: [
                    Expanded(child: Container(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              leading: Image.network("${data[index]['img']}",width: 80,fit:BoxFit.cover),
                              title: "${data[index]['title']} (X${data[index]['qty']}) ".text.size(16).fontFamily(semibold)
                                  .make(),
                              subtitle: "${data[index]['tprice']}".numCurrency.text.size(14).color(redColor).
                              fontFamily(semibold).make(),
                              trailing: IconButton(
                                onPressed: (){
                                  FirestoreService.deletdocument(data[index].id);
                                },
                                icon: Icon(Icons.delete,color: redColor,),
                              ),

                            );

                      }),
                    )),
                    Obx(()=>
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price".text.color(darkFontGrey).fontFamily(semibold).make(),
                          controller.totalP.value.numCurrency.text.color(redColor).fontFamily(semibold).make(),
                        ],
                      ).box.padding(EdgeInsets.all(8)).width( context.screenWidth-60,).color(lightGolden).roundedSM.make(),
                    ),
                   10.heightBox,

                  ],
                ).box.padding(EdgeInsets.all(8)).make();
              }
        },
      )


    );
  }
}
