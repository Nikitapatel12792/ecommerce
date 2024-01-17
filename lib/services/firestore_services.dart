import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/product_controller.dart';

class FirestoreService{
static getUser(uid){
  return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
}
static getProducts(category){

    return firestore.collection(productsCollection).where('p_category',isEqualTo: category,).snapshots();

}
static getCart(uid){
  return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
}
static deletdocument(docid){
  return firestore.collection(cartCollection).doc(docid).delete();
}
static getchatmessage(docid){
  return firestore.collection(chatCollection).doc(docid).
  collection(messageCollection).orderBy('created_on',descending: false).snapshots();

}
static getallorders() {
  return firestore.collection(ordersCollection).where(
      'order_by', isEqualTo: currentUser?.uid).snapshots();

}
static getwishlist(){
  return firestore.collection(productsCollection).where('p_wish',arrayContains: currentUser?.uid).snapshots();
}
static  getallmessage(){
return firestore.collection(chatCollection).
where('fromId',isEqualTo: currentUser?.uid).snapshots();}
  static getcount()async{
  var res= await Future.wait([
    firestore.collection(cartCollection).
  where('added_by',isEqualTo: currentUser?.uid).get().then((value){
    return value.docs.length;
  }),
    firestore.collection(productsCollection).
    where('p_wish',arrayContains : currentUser?.uid).get().then((value){
      return value.docs.length;
    }),
    firestore.collection(ordersCollection).
    where('order_by',isEqualTo: currentUser?.uid).get().then((value){
      return value.docs.length;
    })

  ]);
  return res;
  }
  static allproduct(){
  return firestore.collection(productsCollection).snapshots();
  }
  static getfeaturedproduct(){
  return firestore.collection(productsCollection).where('is_featured',isEqualTo: true).get();
  }
  static serchproduct(title){
  return firestore.collection(productsCollection).where('p_name').get();
  }
  static getsubcatergoryproduct(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo: title,).snapshots();

  }
}