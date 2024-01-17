import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
Widget exitdialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure want to exit? ".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourbutton(color: redColor,onPress: (){
                SystemNavigator.pop();
            },textColor: whiteColor,title: "Yes"),
            ourbutton(color: redColor,onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}