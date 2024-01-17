
import 'package:ecommerce/View/categories_screen/category_detail.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(ProductController());
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back,color: whiteColor,),
    onPressed: () {
   Get.back(); // Use Navigator to go back
    },),
          title: categories.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
              mainAxisSpacing: 9,
              mainAxisExtent: 200,
              crossAxisSpacing: 9),
              itemBuilder: (context,index){
            return Column(
              children: [Image.asset(categoriesimg[index],height: 120,width: 200,fit: BoxFit.cover,),
              10.heightBox,
                categorieslist[index].text.color(darkFontGrey).align(TextAlign.center).make()
              ],
            ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
              controller.getSubcategories(categorieslist[index]);
              Get.to(CategoryDetailSacreen(title: categorieslist[index],));});
              }),
        ),
      )
    );
  }
}
