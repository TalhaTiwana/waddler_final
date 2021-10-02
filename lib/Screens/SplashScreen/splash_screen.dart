import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Screens/Auth/login_screen.dart';
import 'package:waddler/Screens/Home/home_screen.dart';
import 'package:waddler/Style/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool state;
  @override
  void initState() {
    state = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (state) {
      setState(() {
        moveToLoginScreen(context);
        state = false;
      });
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("images/waddler_logo.png"),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.08),
              width: size.width,
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Waddler',
                    textStyle: GoogleFonts.courgette(
                        letterSpacing: 1,
                        color: primaryDarkClr,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.09),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 600),
                displayFullTextOnTap: false,
                stopPauseOnTap: false,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    ));
  }

  moveToLoginScreen(BuildContext context) {
    try {
      Future.delayed(const Duration(seconds: 3), () {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            screenPushRep(context, const LoginScreen());
          } else {
            screenPushRep(context, const HomeScreen());
          }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
