



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/categories_screen/Item_detail.dart';
import 'package:ecommerce/View/home_screen/featured_button.dart';
import 'package:ecommerce/View/home_screen/search_screen.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controller/home_controller.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: lightGrey,
              child:TextFormField(
                controller: controller.searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  hintStyle: TextStyle(color: textfieldGrey),
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if(controller.searchcontroller.text.isNotEmpty){
                      Get.to(()=>SearchScreen(title: controller.searchcontroller.text,));
                    }

                        
                  })
                ),
              ) ,
            ),
            //swipersbrand
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16/9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemBuilder: (context,index){
                        return Image.asset(sliderlist[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).
                        margin(EdgeInsets.symmetric(horizontal: 8)).make();
                      }, itemCount: sliderlist.length,),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => homebutton(
                          height: context.screenHeight*0.13,
                          width: context.screenWidth/2.5,
                          icon: index==0?icTodaysDeal:icFlashDeal,
                          title:index==0?todaydeal:flashsale)),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16/9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemBuilder: (context,index){
                        return Image.asset(secondsliderlist[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).
                        margin(EdgeInsets.symmetric(horizontal: 8)).make();
                      }, itemCount: secondsliderlist.length,),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:List.generate(3, (index) => homebutton(
                        height: context.screenHeight*0.13,
                        width: context.screenWidth/3.5,
                        icon: index==0?icTopCategories:index==1?icBrands:icFlashDeal,
                        title:index==0?topcategories:index==1?brand:topsellers,
                      )),
                    ),
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featheredcatedgories.text.color(darkFontGrey).
                        size(18).fontFamily(semibold).make()),
                    20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) => Column(children: [
                    featuredbutton(icon: featuredimage1[index],title: featuredtitlelist1[index]),
                    10.heightBox,
                    featuredbutton(icon: featuredimage2[index],title: featuredtitlelist2[index])
                  ],)),
                ),
              ),
                    20.heightBox,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredproduct.text.white.fontFamily(bold).size(18).make().box.padding(EdgeInsets.all(10)).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreService.getfeaturedproduct(),
                              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                else if(snapshot.data!.docs.isEmpty){
                                  return "No Feature product".text.white.makeCentered();
                                }
                                else{
                                  var fdata =snapshot.data!.docs;
                                  return
                                  Row(
                                    children: List.generate(fdata.length, (index) =>
                                        Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(fdata[index]['p_images'][0],
                                          height: 130,
                                          width: 150,fit: BoxFit.cover,),
                                        10.heightBox,
                                        "${fdata[index]['p_name']}"
                                                      .text.fontFamily(bold).color(darkFontGrey).
                                        make(),
                                        10.heightBox,
                                        "${fdata[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make()
                                      ],

                                    ).box.white.roundedSM.padding(EdgeInsets.all(8)).
                                    margin(EdgeInsets.symmetric(horizontal: 8,vertical: 10)).make().
                                        onTap(() {
                                          Get.put(ProductController());
                                       Get.to(()=>ItemDetail(
                                         data:fdata[index] ,
                                         title: "${fdata[index]['p_name']}",
                                       ));
                                        })),
                                  );

                                }

                              },
                            )



                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16/9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemBuilder: (context,index){
                        return Image.asset(secondsliderlist[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).
                        margin(EdgeInsets.symmetric(horizontal: 8)).make();
                      }, itemCount: secondsliderlist.length,),
                    //all product,
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child:"All Product".text.size(22).fontFamily(bold).make() ,
                    ),
                    10.heightBox,
                    StreamBuilder(stream: FirestoreService.allproduct(),
                        builder:  (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else{
                        var data=snapshot.data!.docs;
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 300,
                                crossAxisCount: 2
                            ), itemBuilder: (context,index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(data[index]['p_images'][0],width: 200,height: 200,fit: BoxFit.cover,),
                              const Spacer(),
                             "${data[index]['p_name']}"
                                          .text.fontFamily(bold).color(darkFontGrey).
                              make(),
                              10.heightBox,
                              "${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()
                            ],
                          ).box.white.padding(EdgeInsets.all(12)).make().onTap(() {
                            Get.put(ProductController());
                            Get.to(()=>ItemDetail(title: data[index]['p_name'],
                            data: data[index],));});
                        });
                      }
                        })

                  ],
                ),
              ),
            )
             ],
        ),
      ),
    );
  }
}
