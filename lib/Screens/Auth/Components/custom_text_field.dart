import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.controller,
      required this.onChange,
      this.hintText,
      this.prefixIcon,
      this.keyBoardType,
      this.errorText,
      this.suffixIcon,
      this.readOnly: false})
      : super(key: key);
  final suffixIcon;
  final controller;
  final onChange;
  final hintText;
  final prefixIcon;
  final keyBoardType;
  final errorText;
  final readOnly;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Container(
        height: size.height * 0.06,
        margin: EdgeInsets.only(top: size.height * 0.02),
        child: TextField(
          keyboardType: keyBoardType,
          onChanged: onChange,
          controller: controller,
          readOnly: readOnly,
          style: TextStyle(
              color: GetStorage().read('isDark') == true
                  ? Colors.white
                  : Colors.grey.shade700),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            errorText: errorText,
            suffixIcon: suffixIcon,
            prefixIcon: Icon(
              prefixIcon,
              color: GetStorage().read('isDark') == true
                  ? Colors.white
                  : Colors.grey.shade700,
            ),
            border: InputBorder.none,
            hintText: "$hintText",
            errorStyle: GoogleFonts.zillaSlab(
                color: Colors.red,
                fontSize: size.width * 0.03,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                height: 0.1),
            hintStyle: GoogleFonts.zillaSlab(
              color: GetStorage().read('isDark') == true
                  ? Colors.white
                  : Colors.black,
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
              height: 2.8,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: GetStorage().read('isDark') == true
                    ? Colors.white
                    : Colors.black.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
