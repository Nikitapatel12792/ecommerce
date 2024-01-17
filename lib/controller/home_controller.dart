import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }
RxInt currentindexnav=0.obs;
var username="";
var searchcontroller=TextEditingController();
getUsername()async{
  var n=await firestore.collection(usersCollection).where('id',isEqualTo: currentUser?.uid).get().
  then((value) {
    if(value.docs.isNotEmpty){
      return value.docs.single['name'];
    }
  });
  username=n;
}

}