import 'dart:io';

import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/profile_controller.dart';
import 'package:ecommerce/widgets/bg_widget.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProfileController>();

    return  bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(

        ),
        body: Obx(()
          => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] =="" &&  controller.profileImagepath.isEmpty ?
              Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).box.
              roundedFull.clip(Clip.antiAlias).make(): data['imageUrl'] !="" &&
                  controller.profileImagepath.isEmpty ?Image.network( data['imageUrl'],width: 100,fit: BoxFit.cover,).
        box.roundedFull.clip(Clip.antiAlias).make():
              Image.file(File(controller.profileImagepath.value,),width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourbutton(color: redColor,onPress: (){
                controller.changeImage(context);
              },textColor: whiteColor,title: "Change"),
              Divider(),
              20.heightBox,
              customtextfield(hint: name,title: name,ispass: false,controller: controller.name),
              10.heightBox,
              customtextfield(hint: passwordhint,title: "Old Password",ispass: true,
                  controller: controller.oldpass),
              10.heightBox,
              customtextfield(hint: passwordhint,title: "New Password",ispass: true,
                  controller: controller.newpass),
              20.heightBox,
             controller.isloading.value?CircularProgressIndicator(): SizedBox(
                  width: context.screenWidth-60,
                  child: ourbutton(title: "save",textColor: whiteColor,

                      onPress: ()async{
                        controller.isloading(true);
                        //for check image
                        if(controller.profileImagepath.value.isNotEmpty){
                          await controller.uploadprofileimage();
                        }else{
                          controller.profileimagelink=data['imageUrl'];
                        }
                        //for compare old password
                        if(data['password'] == controller.oldpass.text){
                          await controller.changeAuthpassword(email: data['email'],
                          password:controller.oldpass.text,
                            newpassword: controller.newpass.text
                          );
                          await controller.updateprofile(
                              imgUrl: controller.profileimagelink,
                              name1: controller.name.text,
                              password1: controller.newpass.text
                          );
                          VxToast.show(context, msg: "uploded");
                        }
                        else{
                          VxToast.show(context, msg: "Wrong Old Password");
                          controller.isloading(false);
                        }
                      },color: redColor))
            ],
          ).box.white.shadowSm.roundedSM.margin(EdgeInsets.only(top: 50,left: 12,right: 12)).padding(EdgeInsets.all(15)).make(),
        ),
      )
    );
  }
}
