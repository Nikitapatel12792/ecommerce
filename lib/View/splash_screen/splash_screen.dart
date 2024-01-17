import 'package:ecommerce/View/auth_screen/login_screen.dart';
import 'package:ecommerce/View/home_screen/home.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/widgets/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changescreen(){
    Future.delayed(Duration(seconds: 3),(){
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(LoginScreen());
        }
        else{
          Get.to(Home());
        }
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changescreen();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
           Align(
               alignment: Alignment.topLeft,
               child: Image.asset(icSplashBg,width: 300,color: Colors.white,)),
            20.heightBox,
            applogowidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(20).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.make(),
            3.heightBox,
          ],
        ),
      ),
    );
  }
}
