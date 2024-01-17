import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var totalP=0.obs;
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var pincodeController=TextEditingController();
  var phoneController=TextEditingController();
  var paymentinsex=0.obs;
   late dynamic productSnapshot;
  var products=[];
  var vendors=[];
  var placeoredr=false.obs;

  calculate(data){
    totalP.value=0;
    for(var i=0;i<data.length;i++){

      totalP.value=totalP.value+int.parse(data[i]['tprice'].toString());
    }
  }
changepaymentindex(index){
    paymentinsex.value=index;
}
placemyorder({required orderpaymentmethod,required totalamount})async{
    placeoredr(true);
    await getproductdetail();
 await firestore.collection(ordersCollection).doc().set({

   'order_by':currentUser?.uid,
   'order_date':FieldValue.serverTimestamp(),
   'order_by_name':Get.find<HomeController>().username,
   'order_by_email':currentUser?.email,
   'order_by_address':addressController.text,
 'order_by_state':stateController.text,
   'order_by_city':cityController.text,
   'order_by_pincode':pincodeController.text,
   'order_by_phone':phoneController.text,
   'sipping_method':"Home Delivery",
   'payment_method':orderpaymentmethod,
   'order_placed':true,
   'order_confirm':false,
   'order_delivered':false,
   'order_on_delivery':false,
   'order_code':"312323232",
   'total_amount':totalamount,
   'Orders':FieldValue.arrayUnion(products),
    'vendors':FieldValue.arrayUnion(vendors),

 });
 placeoredr(false);
}
getproductdetail(){
    products.clear();
    vendors.clear();
    for(var i=0;i<productSnapshot.length;i++){
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
        'vendor_id':productSnapshot[i]['vendor_id'],
          'tprice':productSnapshot[i]['tprice'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }

}
clearcart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
}
}