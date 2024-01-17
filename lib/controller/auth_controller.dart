import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class AuthController extends GetxController{
var emailcontroller=TextEditingController();
var passcontroller=TextEditingController();
  //login
    Future<UserCredential?> loginMethod({context})async{
      UserCredential? userCredential;

      try{
        UserCredential result=
       await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passcontroller.text,);
       print(result.user);
      }on FirebaseAuthException catch(e){
        print("Passwordwrong");
          VxToast.show(context, msg: e.toString());
      }
      return userCredential;
}
//sign up
  Future<UserCredential?> signupmethod({email,password,context})async{
    UserCredential? userCredential;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
  //store data
    storeUserdata({name,password,email})async{

      DocumentReference store = await firestore.collection(usersCollection).doc(currentUser?.uid);

      store.set({
        'name':name,
        'password':password,
        'email':email,
        'imageUrl':'',
        'id':currentUser?.uid,
        'cart_count':'00',
        'order_count':'00',
        'wish_count':'00'
      });

    }
    //sign out
signoutmethod(context)async{
      try{
      await auth.signOut();
      } catch (e){
        VxToast.show(context, msg: e.toString());
      }
}
}