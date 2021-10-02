
import 'dart:io';

import 'package:flutter/material.dart';

class AUthProvider extends ChangeNotifier{
  late String loginError;
  late String signUpError;
   File? imageFileParent;
  late File imageFileChild;
  String loginErrorGet()=>loginError;
  String signUpErrorGet()=>signUpError;
  File? imageFileGet()=>imageFileParent;
  File imageFileChildGet()=>imageFileChild;

  loginErrorSet(String error){
    loginError = error;
    notifyListeners();
  }

  imageFileSet(File? file){
    imageFileParent = file;
    notifyListeners();
  }

  imageFileChildSet(File file){
    imageFileChild = file;
    notifyListeners();
  }

  signUpErrorSet(String error){
    notifyListeners();
    signUpError = error;
  }

}
