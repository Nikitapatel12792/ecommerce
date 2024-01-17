import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget orderstatus({
  icon,color,String? title,showdone
}){
  return ListTile(
    leading: Icon(icon,color: color,).box.border(color: color).padding(EdgeInsets.all(4)).roundedSM.make(),
  trailing: SizedBox(height: 100,width: 120 ,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        title!.text.color(darkFontGrey).make(),
        showdone?Icon(Icons.done,color: redColor,):Container()
      ],
    ),
  ),
  );
}