import 'package:flutter/material.dart';
import 'package:waddler/Screens/SplashScreen/splash_screen.dart';

Future screenPush(BuildContext context,Widget widget)async{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

screenPushRep(BuildContext context,Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));
}