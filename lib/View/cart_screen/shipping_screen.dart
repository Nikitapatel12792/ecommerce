  import 'package:ecommerce/View/cart_screen/payment_method.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.size(20).color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourbutton(
          onPress: (){
            if(controller.addressController.text.isEmpty ||controller.cityController.text.isEmpty||
                controller.stateController.text.isEmpty
            || controller.pincodeController.text.isEmpty || controller.phoneController.text.isEmpty){
              VxToast.show(context, msg: "Please fill the form");
            }
            else{
              Get.to(PaymentMethods());
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue"
        ),
      ),
      body: Column(
        children: [
          customtextfield(hint: "Address",title: "Address",ispass: false,controller: controller.addressController),
          10.heightBox,
          customtextfield(hint: "City",title: "City",ispass: false,controller: controller.cityController),
          10.heightBox,
          customtextfield(hint: "State",title: "State",ispass: false,controller: controller.stateController),
          10.heightBox,
          customtextfield(hint: "Pincode",title: "Pincode",ispass: false,controller: controller.pincodeController),
          10.heightBox,
          customtextfield(hint: "Phone",title: "Phone",ispass: false,controller: controller.phoneController),
        ],
      ).box.padding(EdgeInsets.all(15)).make(),
    );
  }
}
