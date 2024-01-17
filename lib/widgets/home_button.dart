import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homebutton({height, width, String? title, icon, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
