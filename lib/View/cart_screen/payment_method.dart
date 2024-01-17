import 'package:ecommerce/View/home_screen/home.dart';
import 'package:ecommerce/View/home_screen/home_screen.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(()=>
      Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child:controller.placeoredr.value?Center(child: CircularProgressIndicator(),): ourbutton(
              onPress: () async {
               await controller.placemyorder(orderpaymentmethod: paymentmethodlist[controller.paymentinsex.value],totalamount: controller.totalP.value);
                await controller.clearcart();
                VxToast.show(context, msg: "Order Placed successfully");
                Get.offAll(Home());
              },
              color: redColor,
              textColor: whiteColor,
              title: "Place my order"),
        ),
        appBar: AppBar(
          title: "Choose payment method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Obx(
          () => Column(
              children: List.generate(
                  paymentmethodimage.length,
                  (index) => GestureDetector(
                        onTap: () {
                          controller.changepaymentindex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.paymentinsex.value == index
                                      ? redColor
                                      : Colors.transparent,
                                  width: 5),
                              borderRadius: BorderRadius.circular(12)),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.asset(
                                paymentmethodimage[index],
                                width: double.infinity,
                                colorBlendMode: controller.paymentinsex.value == index?  BlendMode.darken:BlendMode.color,
                                color:controller.paymentinsex.value == index? Colors.black.withOpacity(0.4):Colors.transparent,
                                fit: BoxFit.cover,
                                height: 120,
                              ),
                              controller.paymentinsex.value == index
                                  ? Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                          activeColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          value: true,
                                          onChanged: (value) {}),
                                    )
                                  : Container(),
                              Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: "${paymentmethodlist[index]}".text.white.fontFamily(semibold).size(16).make())
                            ],
                          ),
                        ),
                      ))).box.padding(EdgeInsets.all(10)).make(),
        ),
      ),
    );
  }
}
