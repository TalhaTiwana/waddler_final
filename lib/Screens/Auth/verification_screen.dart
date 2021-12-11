import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Common/snackbar.dart';
import 'package:waddler/Screens/main_screen/main_screen.dart';
import 'package:waddler/Services/firebase_auth.dart';
import 'dart:math';

import 'package:waddler/Style/colors.dart';

class VerificationScreen extends StatefulWidget {
  final String password;
  final String email;
  final String phoneNumber;
  const VerificationScreen(
      {Key? key,
      required this.password,
      required this.email,
      required this.phoneNumber})
      : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _controller = TextEditingController();
  bool buttonIsPressed = false;
  TwilioFlutter? twilioFlutter;
  String? number;
  generateNum() {
    Random rng = Random();
    setState(() {
      number =
          '${rng.nextInt(9)}${rng.nextInt(9)}${rng.nextInt(9)}${rng.nextInt(9)}${rng.nextInt(9)}${rng.nextInt(9)}';
    });
    print("${number}");
    FirebaseAuth.instance.signOut();
  }

  var textColor;
  @override
  void initState() {
    generateNum();
    textColor =
        GetStorage().read('isDark') == true ? Colors.white : Colors.black;
    print("sent $number");
    super.initState();
    twilioFlutter = TwilioFlutter(
        accountSid:
            'AC0c9bc30e28fa34cd35d09ee880d7a507', // replace *** with Account SID
        authToken:
            '39c0383f7c2be368bcead371db6753d9', // replace xxx with Auth Token
        twilioNumber: '+18037841913' // replace .... with Twilio Number
        );
    twilioFlutter!.sendSMS(
        toNumber: widget.phoneNumber,
        messageBody: 'Your verification code is $number  ');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor:
          GetStorage().read('isDark') == true ? Colors.black : Colors.white,
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(2.0, 2.0),
                colors: [
              primaryClrLightTheme.withOpacity(0.8),
              primaryClrLightTheme.withOpacity(0.5)
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.27,
              ),
              Text(
                "Verification",
                style: GoogleFonts.cabin(
                    color: textColor,
                    fontSize: size.width * 0.08,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Please enter your verification code we have just sent you on your mobile number",
                style: GoogleFonts.cabin(
                    color: textColor,
                    fontSize: size.width * 0.045,
                    letterSpacing: 1),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: PinCodeTextField(
                  cursorColor: Colors.white,
                  autoFocus: true,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    activeFillColor: Colors.blue,
                    fieldWidth: 40,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: _controller,
                  onCompleted: (v) async {
                    if (v == number) {
                      var data = await Authentication().signInWithEmail(
                          email: widget.email,
                          password: widget.password,
                          context: context);
                      if (data != null) {
                        showSnackBarSuccess(context, 'verification completed');
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'userIsVerified': true});
                        screenPushRep(context, MainScreen());
                      }
                    } else {
                      showSnackBarFailed(
                          context, 'Code is wrong please try again');
                    }
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              MaterialButton(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.35,
                    vertical: size.height * 0.02),
                color: primaryDarkClrLightTheme,
                onPressed: !buttonIsPressed
                    ? () {
                        setState(() {
                          buttonIsPressed = true;
                        });
                      }
                    : null,
                child: buttonIsPressed
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        "Send code",
                        style: GoogleFonts.cabin(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.04),
                      ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
