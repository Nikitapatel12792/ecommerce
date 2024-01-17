import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourbutton({onPress,color,textColor,String? title}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(10),
        shape: BeveledRectangleBorder()

      ),
      onPressed:
      onPress,

      child: title!.text.color(textColor).fontFamily(bold).make());
}