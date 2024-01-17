import 'package:ecommerce/View/auth_screen/signup_screen.dart';
import 'package:ecommerce/View/home_screen/home.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/widgets/applogo_widget.dart';
import 'package:ecommerce/widgets/bg_widget.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    return  bgwidget(child:Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox,
            applogowidget(),
            10.heightBox,
            "Log in to $appname".text.white.size(18).fontFamily(bold).make(),
            15.heightBox,
            Column(
              children: [
                customtextfield(controller: controller.emailcontroller,hint: emailhint,
                ispass: false,
                title: email),
                customtextfield(hint: passwordhint,controller: controller.passcontroller,
                    ispass: true,
                    title: password),
                Align(
                  alignment: Alignment.topRight,
                    child: TextButton(onPressed: (){}, child: forgetpass.text.make())),
              5.heightBox,
                ourbutton(title: login,color: redColor,textColor: whiteColor,
                    onPress: ()async{
                    await controller.loginMethod(context: context).then((value) {

                        if(value !=null){
                          Get.offAll(Home());
                        }
                    });

                }).box.width(context.screenWidth-50).make(),
                5.heightBox,
                createnewaccoutn.text.color(fontGrey).make(),
                5.heightBox,
                ourbutton(title: signup,color: lightGolden,textColor: redColor,
                    onPress: (){
                  Get.to(SignupSceen());
                    }).box.width(context.screenWidth-50).make(),
                10.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List<Widget>.generate(3, (index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(socialIconList[index],width: 30,),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ).box.white.rounded.width(context.screenWidth -70).shadowSm.padding(EdgeInsets.all(16)).make()

          ],
        ),
      ),
    ));
  }
}
