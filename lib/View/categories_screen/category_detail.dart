import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/categories_screen/Item_detail.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
class CategoryDetailSacreen extends StatefulWidget {
  final String? title;
  CategoryDetailSacreen({super.key, this.title});


  @override
  State<CategoryDetailSacreen> createState() => _CategoryDetailSacreenState();
}

class _CategoryDetailSacreenState extends State<CategoryDetailSacreen> {
  dynamic productMethod;
  var controller = Get.find<ProductController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    swichCategory(widget.title);
  }
  swichCategory(title){
    if(controller.subcat.contains(title)){
      productMethod=  FirestoreService.getsubcatergoryproduct(title);
    }
    else{
      productMethod=  FirestoreService.getProducts(title);
    }
  }
  @override
  Widget build(BuildContext context) {


    return bgwidget(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
                onPressed: () {
                  Get.back(); // Use Navigator to go back
                },
              ),
              title: widget.title!.text.white.fontFamily(bold).make(),
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        controller.subcat.length,
                            (index) => "${controller.subcat[index]}"
                            .text
                            .align(TextAlign.center)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .makeCentered()
                            .box
                            .size(120, 60)
                            .margin(
                            EdgeInsets.symmetric(horizontal: 4))
                            .rounded
                            .padding(
                            EdgeInsets.symmetric(horizontal: 8))
                            .white.border(color:controller.selectinsex.value == index ?Colors.black:Colors.transparent, width: 2)
                            .make().onTap(() {
                              controller.changeselectindex(index);
                              swichCategory("${controller.subcat[index]}");
                              setState(() {

                              });
                            })),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                    stream:productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No Product found".text.color(darkFontGrey).makeCentered(),
                        );
                      } else {
                        var data=snapshot.data!.docs;
                        return Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                GridView.builder(

                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 250),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            '${data[index]['p_images'][0]}',
                                            width: 200,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          '${data[index]['p_name']}'
                                              .text
                                              .fontFamily(bold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          '${data[index]['p_price']}'.numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .padding(EdgeInsets.all(12))
                                          .roundedSM
                                          .outerShadowSm
                                          .make()
                                          .onTap(() {
                                        controller.checkisfav(data[index]);
                                        Get.to(ItemDetail(
                                          title: '${data[index]['p_name']}',data: data[index],
                                        ));
                                      });
                                    })
                              ]),
                        );
                      }
                    }),
              ],
            )));
  }
}


