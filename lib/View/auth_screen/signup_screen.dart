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

class SignupSceen extends StatefulWidget {
  const SignupSceen({super.key});

  @override
  State<SignupSceen> createState() => _SignupSceenState();
}

class _SignupSceenState extends State<SignupSceen> {
  bool isChecked=false;
  var controller =Get.put(AuthController());
  TextEditingController _name=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  TextEditingController _rpass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  bgwidget(child:Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox,
            applogowidget(),
            10.heightBox,
            "Join to the $appname".text.white.size(18).fontFamily(bold).make(),
            15.heightBox,
            Column(
              children: [
                customtextfield(hint: name,controller: _name,  ispass: false,
                    title: name),
                customtextfield(hint: emailhint,controller: _email,  ispass: false,
                    title: email),
                customtextfield(hint: passwordhint,controller: _pass,  ispass: true,
                    title: password),
                customtextfield(hint: passwordhint,controller: _rpass,  ispass: true,
                    title: retype),
                5.heightBox,
                Row(children: [
                  Checkbox(
                      checkColor: redColor,
                      value: isChecked, onChanged: (newvalue){
                        setState(() {
                          isChecked=newvalue!;
                        });
                  }),
                  10.widthBox,
                  Expanded(
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                              text: "I agree tp the ",style: TextStyle(
                              color: fontGrey,
                              fontFamily: regular
                          )),
                          TextSpan(
                              text: termsnadcondition,style: TextStyle(
                              color: redColor,
                              fontFamily: regular
                          )),
                          TextSpan(
                              text: " & ",style: TextStyle(
                              color: fontGrey,
                              fontFamily: regular
                          )),
                          TextSpan(
                              text: privacypolicy,style: TextStyle(
                              color: redColor,
                              fontFamily: regular
                          ))
                        ]
                    )),
                  )
                ],),
                5.heightBox,
                ourbutton(title: signup,
                    color: isChecked?redColor:lightGrey,textColor: whiteColor,
                    onPress: ()async{
                  print(_email.text.toString());
                  if(isChecked != false){
                    try{
                     await controller.signupmethod(password: _pass.text.toString(),
                       email: _email.text.toString(),
                       context: context,).then((value) {
                         print("gngfmn");
                         return controller.storeUserdata(
                             email: _email.text,password: _pass.text,name: _name.text);

                     }).then((value){
                       VxToast.show(context, msg: "Login Successfully");
                       Get.offAll(Home());
                     });
                    } catch(e){
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                    }
                  }

                    }).box.width(context.screenWidth-50).make(),
                5.heightBox,
               RichText(text: TextSpan(
                 children:[
                   TextSpan(
                     text: alreadyaccount,style: TextStyle(
                     fontFamily: regular,
                     color: fontGrey
                   )
                   ),
                   TextSpan(
                       text: login,style: TextStyle(
                       fontFamily: regular,
                       color: redColor
                   )
                   ),
                 ]
               )).onTap(() {
                 Get.back();
               })
              ],
            ).box.white.rounded.width(context.screenWidth -70).shadowSm.padding(EdgeInsets.all(16)).make()

          ],
        ),
      ),
    ));
  }
}
