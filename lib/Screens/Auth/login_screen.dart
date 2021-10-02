import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Screens/Auth/singup_screen_parents.dart';
import 'package:waddler/Screens/Home/home_screen.dart';
import 'package:waddler/Services/firebase_auth.dart';
import 'package:waddler/Style/colors.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool passwordIsVisible;
  String? errorOnEmail;
  String? errorOnPassword;
  late bool loading;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    loading = false;
    passwordIsVisible =true;
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
        backgroundColor: primaryClr,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient:LinearGradient(
                colors: [
            primaryClr,
                  primaryDarkClr
                ]
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04),

              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height*0.5,
                  ),
                  Positioned(
                    left: size.width*0.02,
                    top: size.height*0.19,
                    child: Text("Welcome\nBack!",style: GoogleFonts.zillaSlab(
                      fontSize: size.width*0.09,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                        width: size.width*0.7,
                        child: Image.asset("images/login_image.png")),
                  )
                ],
              )
            ),
                Container(
                    width: size.width,
                    height: size.height*0.5,
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
                    decoration: BoxDecoration(
                  color: bgColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                    ),
                    child:SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height*0.06,
                                left: size.width*0.04,right: size.width*0.04
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text("Please Sign In",style: GoogleFonts.cabin(color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width*0.06),),
                              Visibility(
                                  visible:loading ,
                                  child: CircularProgressIndicator()),
                            ],)
                          ),
                          SizedBox(
                            height: size.height*0.03,
                          ),
                          Container(
                            height: size.height*0.06,
                            margin: EdgeInsets.only(top: size.height*0.02),
                            child: TextField(
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.zillaSlab(
                                    color: Colors.black,
                                    fontSize: size.width*0.045,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                      height: 2.8
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!.withOpacity(0.8),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                              onChanged: (value){
                                errorCheck(1, value.toString());
                              },
                            ),
                          ),
                          Container(
                            height: size.height*0.06,
                            margin: EdgeInsets.only(top: size.height*0.02),
                            child: TextField(
controller: _controllerPassword,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: passwordIsVisible,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  prefixIcon: Icon(Icons.vpn_key),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.zillaSlab(
                                    color: Colors.black,
                                    fontSize: size.width*0.045,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    height: 2.8,
                                  ),
                                  suffixIcon: IconButton(icon: Icon(passwordIsVisible?Icons.visibility_off:Icons.remove_red_eye),onPressed: (){
                                    setState(() {
                                      passwordIsVisible=!passwordIsVisible;
                                    });
                                  },),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!.withOpacity(0.8),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                              onChanged: (value){
                                errorCheck(2, value.toString());
                              },
                            ),
                          ),
                          SizedBox(
                            height: size.height*0.03,
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                loading = true;
                              });
                              singIn(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: size.height*0.025),
                              alignment: Alignment.center,
                              height: size.height*0.06,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: primaryDarkClr,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:Text("  Sign In",style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.w600,fontSize: size.width*0.045),)

                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(top: size.height*0.025),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap:(){
                          screenPush(context, ForGotPassword());
                        },
                                child: Text("Forget password?",style: TextStyle(
                                  color: primaryDarkClr,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),),
                              ),
                              InkWell(
                                onTap: (){
                                  screenPush(context, SignUpScreenParents());
                                },
                                child: Text("Sign Up",style: TextStyle(
                                    color: primaryDarkClr,
                                    letterSpacing: 1,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w800
                                ),),
                              )
                            ],
                          ),
                        )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
    ));
  }

  errorCheck(int code,String text){
    if(code ==1){
      if(EmailValidator.validate(text)){
        setState(() {
          errorOnEmail = null;
        });
      }else{
        setState(() {
          errorOnEmail = "Email is not Valid";
        });
      }
    }else if(code == 2){
      if(text.length<5){
setState(() {
  errorOnPassword ="Password is short";

});
      }else{
       setState(() {
         errorOnPassword = null;
       });
      }
    }
  }

singIn(BuildContext context)async{
    if(errorOnPassword ==null && errorOnEmail == null){
     var data  = await  Authentication().signInWithEmail(email: _controllerEmail.text,password: _controllerPassword.text,context: context);
     if(data!=null){
       screenPushRep(context, HomeScreen());
       setState(() {
         loading = false;
       });
     }else{
       setState(() {
         loading = false;
       });
       Fluttertoast.showToast(msg:'${Provider.of<AUthProvider>(context,listen: false).loginErrorGet()}',textColor: Colors.white,backgroundColor: Colors.red.shade900);
     }
    }else{
    if(errorOnEmail!=null){
      Fluttertoast.showToast(msg:'$errorOnEmail' ,textColor: Colors.white,
          backgroundColor: Colors.red.shade900);

    }else if(errorOnPassword!=null){
      Fluttertoast.showToast(msg:'$errorOnPassword' ,textColor: Colors.white,
      backgroundColor: Colors.red.shade900);
    }
    }
}
}
