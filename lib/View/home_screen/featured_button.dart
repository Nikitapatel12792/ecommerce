import 'package:ecommerce/View/categories_screen/category_detail.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
Widget featuredbutton({String? title,icon}){
  return Row(
children: [
  Image.asset(icon,width: 60,fit: BoxFit.fill,),
  10.widthBox,
  title!.text.color(darkFontGrey).fontFamily(semibold).make()
],
  ).box.
  roundedSM.outerShadowSm.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).
  padding(EdgeInsets.all(4)).make().onTap(() {
    Get.put(ProductController());
    Get.to(()=>CategoryDetailSacreen(title: title,));
  });
}