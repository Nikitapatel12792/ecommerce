import 'package:flutter/cupertino.dart';
import 'package:ecommerce/consts/consts.dart';

Widget bgwidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            imgBackground
        ),fit: BoxFit.fill)
    ),
    child: child,
  );
}