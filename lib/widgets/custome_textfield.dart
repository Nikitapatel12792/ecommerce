import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';
Widget customtextfield({String? title,String? hint,controller,bool? ispass}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title!.text.color(redColor).fontFamily(semibold).size(15).make(),
        5.heightBox,
        TextFormField(
          obscureText: ispass!,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
              hintStyle: TextStyle(
                fontFamily: semibold,
                 color: textfieldGrey
              ),
              isDense: true,
              filled: true,
              fillColor: lightGrey,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: redColor
              )
            )
          ),
        ),
        5.heightBox
      ],
    );
}