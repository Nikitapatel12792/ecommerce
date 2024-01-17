

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/View/auth_screen/login_screen.dart';
import 'package:ecommerce/View/chat_screen/message_screen.dart';
import 'package:ecommerce/View/order_screen/order_screen.dart';
import 'package:ecommerce/View/profile_screen/component/detail_card.dart';
import 'package:ecommerce/View/profile_screen/edit_profile.dart';
import 'package:ecommerce/View/wish_screen/wishlist_screen.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/profile_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});


  @override
  Widget build(BuildContext context) {
    var controller= Get.put(ProfileController());

    return bgwidget(
      child: Scaffold(

        body: StreamBuilder(

          stream: FirestoreService.getUser(currentUser?.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
            }
            else{


              var data=snapshot.data!.docs[0];


              return SafeArea(child:
              Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.edit_outlined,color: whiteColor,)).onTap(() {
                    controller.name.text=data['name'];

                    Get.to(EditProfile(data: data,));
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageUrl'] == ""?
                        Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).
                        box.roundedFull.clip(Clip.antiAlias).make()
                        :Image.network( data['imageUrl'],width: 100,fit: BoxFit.cover,).
                        box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                              .text.fontFamily(semibold).white.make(),
                              5.heightBox,
                              "${data['email']}".text.fontFamily(semibold).white.make(),

                            ],
                          ),
                        ),
                        GestureDetector(

                            onTap: ()async{
                              await Get.put(AuthController()).signoutmethod(context);
                              Get.offAll(LoginScreen());
                            },
                            child:"Logout".text.fontFamily(semibold).white.make().box.padding(EdgeInsets.symmetric(horizontal: 10,vertical: 5)).border(color: whiteColor).make() )
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(future: FirestoreService.getcount(),
                      builder: (BuildContext context,AsyncSnapshot snapshot){

                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    else{
                      var countdata =snapshot.data;
                      return
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            detailbutton(title: "In your cart",width: context.screenWidth/3.2,
                                count: countdata[0].toString()),
                            detailbutton(title: "In your wishlist",width: context.screenWidth/3.2,
                                count:  countdata[1].toString()),
                            detailbutton(title: "your Orders ",width: context.screenWidth/3.2,
                                count:  countdata[2].toString())
                          ],
                        );
                    }



                      }),


                  //buttton section
                  ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context,index){
                        return Divider(
                          color: lightGrey,
                        );
                      },
                      itemBuilder:(context,index){
                        return ListTile(
                          onTap: (){
                            switch(index){
                              case 0:
                                Get.to(OrderScreen());
                                break;
                              case 1:
                                Get.to(WishListScreen());
                                break;
                              case 2:
                                Get.to(MessageScreen());
                                break;
                            }
                          },
                          title: profilebuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          leading: Image.asset(profilebuttonicon[index],width: 22,),
                        );
                      } ,  itemCount: profilebuttonlist.length).box.white.rounded.shadowSm.margin(EdgeInsets.all(12)).
                  padding(EdgeInsets.symmetric(horizontal: 15)).make().box.color(redColor).make()
                ],
              ));
            }
            return Container();
          },
        )
      )
    );
  }
}
