import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Providers/auth_providers.dart';

class Authentication{


  signInWithEmail({String? email,String? password,BuildContext? context})async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "$email",
          password: "$password"
      );
      if(userCredential.user!.emailVerified){
        return userCredential.user!.uid;
      }else{
        Provider.of<AUthProvider>(context!,listen: false).loginErrorSet("Email is not verified");
        return null;
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Provider.of<AUthProvider>(context!,listen: false).loginErrorSet("No user found for that email");
       return null;
      } else if (e.code == 'wrong-password') {
        Provider.of<AUthProvider>(context!,listen: false).loginErrorSet("Wrong password provided for that user.");
        print('Wrong password provided for that user.');
        return null;
      }
    }
    return null;
  }

  signUpWithEmailAndPasswords({required String email,required String password,required BuildContext context})async{
    try {
       FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "$email",
          password: "$password"
      );

      if (userCredential!=null) {
        User? user = auth.currentUser;
        user!.sendEmailVerification();
        return user;
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Provider.of<AUthProvider>(context,listen: false).signUpErrorSet("The password provided is too weak");
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Provider.of<AUthProvider>(context,listen: false).signUpErrorSet("The account already exists for that email.");
        return null;
      }
    } catch (e) {
      print("Error => "+e.toString());

    }
    return null;
  }
}