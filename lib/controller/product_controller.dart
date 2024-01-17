import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Modals/category_modals.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var quantity=0.obs;
  var colorindex=0.obs;
  var total=0.obs;
  var subcat=[];
 var isfav=false.obs;
  var selectinsex=0.obs;
  changeselectindex(index){
    selectinsex.value=index;
  }
  getSubcategories(title) async{
    subcat.clear();
    var data =await rootBundle.loadString("lib/services/category_modal.json");
    var decoded =categoryModalFromJson(data);
    var s=decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory){

      subcat.add(e);
    }
  }
  changecolorindex(index){
    colorindex.value=index;
  }
  increasequantity(totalquantity){
    if(quantity.value < totalquantity)
    {
      quantity.value++;
    }
  }
  decreasequantity(){
    if(quantity.value >0){
      quantity.value--;
    }

  }
  calculatetotal(price){
    total.value=price*quantity.value;
  }
  addtocart({title,img,sellername,color,qty,tprice,context,vendorid})async{
    await firestore.collection(cartCollection).doc().set({

      'title':title,
      'img':img,
      'sellername':sellername,
      'color':color,
      'qty':qty,
      'vendor_id':vendorid,
      'tprice':tprice,
      'added_by':currentUser?.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }
  resetvalue(){
    quantity.value=0;
    total.value=0;
    colorindex.value=0;
  }
  addtowishlist(docid,context)async{
    await firestore.collection(productsCollection).doc(docid).set({
      'p_wish':FieldValue.arrayUnion([currentUser?.uid])
    },SetOptions(merge: true));
    VxToast.show(context, msg: "Add to wishlist");
  }
 removefromwishlist(docid,context)async{
    await firestore.collection(productsCollection).doc(docid).set({
      'p_wish':FieldValue.arrayRemove([currentUser?.uid])
    },SetOptions(merge: true));
    isfav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }
  checkisfav(data)async{
    if(data['p_wish'].contains(currentUser?.uid)){
      isfav(true);
    }
    else{
      isfav(false);
    }
  }
}