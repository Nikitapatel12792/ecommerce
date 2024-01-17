import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{
    var profileImagepath=''.obs;
    var profileimagelink='';
    var isloading=false.obs;
    var name=TextEditingController();
    var oldpass=TextEditingController();
    var newpass=TextEditingController();

    changeImage(context)async{
      try{
        final img=await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 70);
        if(img==null){
          return;
        }
        profileImagepath.value=img.path;

      }on PlatformException catch(e){
            VxToast.show(context, msg: e.toString());
      }


    }
    uploadprofileimage()async{
      var filename=basename(profileImagepath.value);
      var destination='images/${currentUser?.uid}/$filename';
      Reference ref=FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImagepath.value));
      profileimagelink=await  ref.getDownloadURL();
    }
    updateprofile({name1,password1,imgUrl})async{
      var store=firestore.collection(usersCollection).doc(currentUser?.uid);
     await store.set({
        'name':name1,
        'password':password1,

        'imageUrl':imgUrl,

      },SetOptions(merge:true));
     isloading(false);
    }
    changeAuthpassword({email,password,newpassword})async{
      final cred =EmailAuthProvider.credential(email: email, password: password );
      await currentUser?.reauthenticateWithCredential(cred).then((value) {
        currentUser?.updatePassword(newpassword);
      }).catchError((error){
        print(error.toString());
      });
    }
}