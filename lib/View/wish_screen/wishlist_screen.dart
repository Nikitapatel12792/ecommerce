import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/consts/consts.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getwishlist(),
          builder:   (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No order yet!".text.color(darkFontGrey).makeCentered();
            }
            else{
              var data=snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    leading: Image.network("${data[index]['p_images'][0]}",width: 80,fit:BoxFit.cover),
                    title: "${data[index]['p_name']}".text.size(16).fontFamily(semibold)
                        .make(),
                    subtitle: "${data[index]['p_price']}".numCurrency.text.size(14).color(redColor).
                    fontFamily(semibold).make(),
                    trailing: IconButton(
                      onPressed: (){
                       firestore.collection(productsCollection).doc(data[index].id).set({
                         'p_wish':FieldValue.arrayRemove([currentUser?.uid]),
                       },SetOptions(merge: true));
                      },
                      icon: Icon(Icons.favorite,color: redColor,),
                    ),
                
                  );}),
              );
            }
          }
      ),
    );
  }
}
