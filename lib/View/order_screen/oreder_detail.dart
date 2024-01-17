import 'package:ecommerce/View/order_screen/compoents/order_status.dart';
import 'package:ecommerce/View/order_screen/compoents/orderplace_detail.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class Ordersdetail extends StatelessWidget {
  final dynamic data;
  const Ordersdetail({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              orderstatus(color: redColor,icon: Icons.done,title: "Placed",
                  showdone:data['order_placed'] ),
              orderstatus(color:Colors.blue,icon: Icons.thumb_up,title: "Confirmed",
                  showdone:data['order_confirm'] ),
              orderstatus(color: Colors.yellow,icon: Icons.car_crash,title: "On delivery",
                  showdone:data['order_on_delivery'] ),
              orderstatus(color: Colors.purple,icon: Icons.done_all_rounded,title: "Delivered",
                  showdone:data['order_delivered'] ),
              Divider(),
              10.heightBox,
             Column(
               children: [
                 orderplacedetail(d1:data['order_code'],d2: data['sipping_method'],
                     title1: "Order Code", title2: "Shipping Method"),
                 10.heightBox,
                 orderplacedetail(d1:intl.DateFormat().add_yMMMd().format(data['order_date'].toDate()),d2: data['payment_method'],
                   title1: "Order Date", title2: "Payment Method"),
                 10.heightBox,
                 orderplacedetail(d1:"Unpaid",d2: "Order Placed",
                     title1: "Payment Status", title2: "Delivery Status"),
                 10.heightBox,
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 16.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           "Shipping Address".text.fontFamily(semibold).size(18).make(),
                           'Name: ${data['order_by_name']}'.text.make(),
                           'Email: ${data['order_by_email']}'.text.make(),
                           'Address: ${data['order_by_address']}'.text.make(),
                           'City: ${data['order_by_city']}'.text.make(),
                           'State: ${data['order_by_state']}'.text.make(),
                           'Phone: ${data['order_by_phone']}'.text.make(),
                           'Pincode: ${data['order_by_pincode']}'.text.make()
                         ],
                       ),
                       SizedBox(
                         width: 130,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [  "Total Ampount".text.fontFamily(semibold).size(18).make(),
                             '${data['total_amount']}'.text.color(redColor).fontFamily(bold).make(),],
                         ),
                       )
                     ],
                   ),
                 ),
                10.heightBox
               ],
             ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Order Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              
              10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children:List.generate(
                      data['Orders'].length, (index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderplacedetail(title2:data['Orders'][index]['tprice'],
                            title1:data['Orders'][index]['title'],
                            d2: "ReFundable",
                            d1: "${data['Orders'][index]['qty']} x"),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 15,
                          width: 30,
                          color: Color(data['Orders'][index]['color']),
                        ),
                        Divider()
                      ],
                    );
                  }).toList() ,
                ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
        
        
            ],
          ),
        ),
      ),
    );
  }
}
