import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/categories_screen/Item_detail.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SearchScreen extends StatelessWidget {
  String? title;
   SearchScreen({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.make()
      ),
      body: FutureBuilder(
        future:FirestoreService.serchproduct(title) ,
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            print(snapshot.data!.docs);
            return "No Product Found".text.makeCentered();

          }
          else{
            var data =snapshot.data!.docs;
            var filtered=data.where((element) => element['p_name'].toString().
            toLowerCase().contains(title!.toLowerCase())).toList();
            print(filtered);
            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 300),
              children:filtered.mapIndexed((currentValue, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(filtered[index]['p_images'][0],width:200,height: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    "${filtered[index]['p_name']}"
                        .text.fontFamily(bold).color(darkFontGrey).
                    make(),
                    10.heightBox,
                    "${filtered[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()
                  ],
                ).box.white.padding(EdgeInsets.all(12)).make().onTap(() {
                  Get.put(ProductController());
                  Get.to(()=>ItemDetail(title: filtered[index]['p_name'],
                    data: filtered[index],));});
              }).toList(),
            );
          }

        },
      ),

    );
  }
}
