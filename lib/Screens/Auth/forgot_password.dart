import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Style/colors.dart';

class ForGotPassword extends StatefulWidget {
  const ForGotPassword({Key? key}) : super(key: key);

  @override
  _ForGotPasswordState createState() => _ForGotPasswordState();
}

class _ForGotPasswordState extends State<ForGotPassword> {
  final TextEditingController _controller = TextEditingController();
  bool buttonIsPressed = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(2.0, 2.0),
                colors: [
              primaryClr.withOpacity(0.8),
              primaryClr.withOpacity(0.5)
            ])),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.27,
            ),
            Text(
              "ForgotPassword",
              style: GoogleFonts.cabin(
                  color: Colors.black,
                  fontSize: size.width * 0.08,
                  letterSpacing: 1),
            ),
            Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: TextField(
                  controller: _controller,
                )),
            SizedBox(
              height: size.height * 0.06,
            ),
            MaterialButton(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.35, vertical: size.height * 0.02),
              color: primaryDarkClr,
              onPressed: !buttonIsPressed
                  ? () {
                      setState(() {
                        buttonIsPressed = true;
                      });
                      if (EmailValidator.validate(
                          _controller.text.replaceAll(' ', ''))) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _controller.text.replaceAll(' ', ''))
                            .whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Email is sent")));
                          setState(() {
                            buttonIsPressed = false;
                          });
                        });
                      } else {
                        setState(() {
                          buttonIsPressed = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Email is not valid")));
                      }
                    }
                  : null,
              child: buttonIsPressed
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Send reset link",
                      style: GoogleFonts.cabin(
                        color: Colors.white,
                      ),
                    ),
            )
          ],
        ),
      ),
    ));
  }
}
