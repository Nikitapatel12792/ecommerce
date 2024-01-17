import 'package:ecommerce/View/cart_screen/cart_screen.dart';
import 'package:ecommerce/View/categories_screen/categories_screen.dart';
import 'package:ecommerce/View/home_screen/home_screen.dart';
import 'package:ecommerce/View/profile_screen/profile_screen.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/home_controller.dart';
import 'package:ecommerce/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(HomeController());
    var navbaritem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home
      ),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label: categories
      ),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart
      ),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account
      ),
    ];
    var navbody=[
      HomeScreen(),
    CategoriesScreen(),
      CartScreen(),
      Profilescreen()
    ];
    return  WillPopScope(
      onWillPop: ()async{

        showDialog(
            barrierDismissible: false,
            context: context, builder: (context)=>exitdialog(context));
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Obx(()
          => BottomNavigationBar(
            currentIndex: controller.currentindexnav.value,
            onTap: (value){
              controller.currentindexnav.value=value;
            },
            items: navbaritem,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(
               fontFamily: semibold
            ),
            type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
          ),
        ),
        body: Column(
          children: [
            Obx(()=>
             Expanded(
                child: navbody.elementAt(controller.currentindexnav.value),
              ),
            ),
          ],
        )
      ),
    );
  }
}

