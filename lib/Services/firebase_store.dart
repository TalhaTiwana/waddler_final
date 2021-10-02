import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Storage{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

   signUpDataToFireStore(Map<String,dynamic> map){
     _firebaseFirestore.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).
     set(map).whenComplete((){
       print("uploaded data");
     });
   }


}