import 'package:ecommerce/View/chat_screen/chat_screen.dart';
import 'package:ecommerce/View/chat_screen/message_screen.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/consts/our_button.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';

class ItemDetail extends StatelessWidget {
  String? title;
  final dynamic data;
   ItemDetail({super.key,this.title,this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return  WillPopScope(
      onWillPop: ()async{
        controller.resetvalue();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetvalue();
            Get.back();
          }, icon: Icon(Icons.arrow_back,color: darkFontGrey,)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share,color: darkFontGrey,)),
            Obx(()
              => IconButton(onPressed: (){
                if(controller.isfav.value){
                  controller.removefromwishlist(data.id,context);

                }
                else{
                  controller.addtowishlist(data.id,context);
                  controller.isfav(true);
                }


              }, icon: Icon(Icons.favorite,color: controller.isfav.value ? redColor:darkFontGrey)),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Container(
        padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      viewportFraction: 1.0,
                      itemCount: data['p_images'].length,
                    aspectRatio: 16/9,
                    itemBuilder: (context,index){
                      return Image.network( data['p_images'][index],width: double.infinity,fit: BoxFit.cover,);
                    },),
                    10.heightBox,
                    title!.text.color(darkFontGrey).fontFamily(semibold).size(16).make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating'].toString()),
                      onRatingUpdate: (value){},
                      count: 5,
                      maxRating: 5,
                    normalColor: textfieldGrey,selectionColor: golden,size: 25,stepInt: true,),
                    10.heightBox,
                    "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).make()
                          ],
                        )),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                            onTap: (){
                              Get.to(ChatScreen(),arguments: [data['p_seller'],data['vendor_id']]);
                            },
                              child: Icon(Icons.message,color: darkFontGrey,),

                          ),
                        )
                      ],
                    ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 15)).
                    color(textfieldGrey).make(),
                    20.heightBox,
                    Obx(()=>
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children:List.generate(data['p_colors'].length, (index) =>
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox().size(40, 40).
                                        margin(EdgeInsets.symmetric(horizontal: 4)).
                                        color(Color(data['p_colors'][index]).withOpacity(1.0)).
                                        roundedFull.make().onTap(() {
                                          controller.changecolorindex(index);
                                        }),
                                      Visibility(
                                          visible: index==controller.colorindex.value,
                                          child: Icon(Icons.done,color: Colors.white,))

                                      ],
                                    )),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          // quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity ".text.color(textfieldGrey).make(),
                              ),
                                 Row(
                                  children:[
                                    IconButton(onPressed: (){
                                      controller.decreasequantity();
                                      controller.calculatetotal(int.parse(data['p_price']));
                                    },
                                        icon: Icon(Icons.remove)),
                                    controller.quantity.value.text.size(16).color(darkFontGrey).make(),
                                    IconButton(onPressed: (){
                                      controller.increasequantity(int.parse(data['p_quantity']));
                                      controller.calculatetotal(int.parse(data['p_price']));
                                    },
                                        icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)".text.color(textfieldGrey).make()
                                  ]
                                ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                  children:[
                                    '${controller.total.value}'.numCurrency.text.color(redColor).fontFamily(bold).size(16).make()
                                  ]
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    //description section
                    10.heightBox,
                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.
                    color(textfieldGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    //button
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(itemdetsilbutton.length, (index) => ListTile(

                        title: itemdetsilbutton[index].text.color(darkFontGrey).fontFamily(semibold).make(),
                        trailing: Icon(Icons.arrow_forward),
                      ).box.white.margin(EdgeInsets.symmetric(vertical: 5)).make()),
                    ),
                    20.heightBox,
                    productyoumaylike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                            10.heightBox,
                            "Laptop 4GB/64GB".text.fontFamily(bold).color(darkFontGrey).
                            make(),
                            10.heightBox,
                            "\$600".text.color(redColor).fontFamily(bold).size(16).make()
                          ],

                        ).box.white.roundedSM.padding(EdgeInsets.all(8)).margin(EdgeInsets.symmetric(horizontal: 8)).make()),
                      ),
                    )
                  ],
                ),
              ),

        ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourbutton(
                  color: redColor,
                  onPress: (){
                  if(controller.quantity >0){
                    controller.addtocart(
                        vendorid: data['vendor_id'],
                        color: data['p_colors'][controller.colorindex.value],
                        context: context,
                        img: data['p_images'][0],
                        qty: controller.quantity.value,
                        title: data['p_name'],
                        sellername: data['p_seller'],
                        tprice: controller.total.value
                    );
                    VxToast.show(context, msg: "Added to cart");
                  }
                  else{
                    VxToast.show(context, msg: "Quantity can't be 0");
                  }
                  },
                  title: "Add to Cart",
                  textColor: whiteColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
