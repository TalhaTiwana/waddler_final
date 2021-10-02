import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Services/firebase_auth.dart';
import 'package:waddler/Services/firebase_store.dart';
import 'package:waddler/Style/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'Components/custom_text_field.dart';

class SignUpScreenChild extends StatefulWidget {
  final fName;
  final mName;
  final phnNum;
  final fCNIC;
  final mCNIC;
  final homeAddress;
  final officialAddress;
  final email;
  final password;
  const SignUpScreenChild(
      {Key? key,
      this.fName,
      this.mName,
      this.phnNum,
      this.fCNIC,
      this.mCNIC,
      this.homeAddress,
      this.officialAddress,
      this.email,
      this.password})
      : super(key: key);

  @override
  _SignUpScreenChildState createState() => _SignUpScreenChildState();
}

class _SignUpScreenChildState extends State<SignUpScreenChild> {
  final TextEditingController _controller = TextEditingController();

   String? bloodGroup;
   String? bloodGroupValue;
   String? gender;
  String? errorOnNm;
  String? errorOnAge;
  String? errorOnBlood;
  String? childsAge;
  String? uploadImageBtnTxt;
  String? _error;

  final imagePicker = ImagePicker();
  var imagePath1;
  var image1;
  late String link1;
  late bool picState;
  late bool state;


  Future getChildImage(BuildContext _buildContext, Size size) async {
    image1 = await imagePicker.getImage(
        preferredCameraDevice: CameraDevice.front, source: ImageSource.gallery);
    Provider.of<AUthProvider>(_buildContext, listen: false)
        .imageFileChildSet(File(image1.path));
    setState(() {
      imagePath1 = image1.path;
      uploadImageBtnTxt = "Selected";
      picState = false;
    });
  }

  File? file;
 @override
  void initState() {
    super.initState();
    picState = true;
    state = true;
    uploadImageBtnTxt = "Upload Child's Picture";
 }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if(state){
    //   Provider.of<AUthProvider>(context,listen: false).imageFileChildSet(file!);
    //   setState(() {
    //     state = false;
    //   });
    // }

    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
      ),
      body: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.03, top: size.height * 0.05),
                  child: Text(
                    "Child's info",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.black,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                  )),
              CustomTextField(
                controller: _controller,
                hintText: "Child's Name",
                prefixIcon: Icons.person,
                keyBoardType: TextInputType.text,
                onChange: (value) {
                  checkError(1, value);
                },
              ),
              childsAge != null
                  ? Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.02, left: size.width * 0.02),
                      child: Text(
                        "Child's Age",
                        style: GoogleFonts.zillaSlab(
                          color: Colors.black,
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: childsAge == null
                    ? EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.024,
                        right: size.width * 0.024)
                    : null,
                child: DropdownButton<String>(
                  iconEnabledColor: primaryClr,
                  isExpanded: true,
                  elevation: 2,
                  hint: Text(
                    childsAge == null ? "Child's Age" : "   $childsAge",
                    style: GoogleFonts.zillaSlab(
                      color: Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  items: <String>['3', '4', '5', '6', '7', '8']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      childsAge = value!;
                    });
                  },
                ),
              ),
              bloodGroup != null
                  ? Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.02, left: size.width * 0.02),
                      child: Text(
                        "Blood Group",
                        style: GoogleFonts.zillaSlab(
                          color: Colors.black,
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: bloodGroup == null
                    ? EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.024,
                        right: size.width * 0.024)
                    : null,
                child: DropdownButton<String>(
                  iconEnabledColor: primaryClr,
                  isExpanded: true,
                  elevation: 2,
                  hint: Text(
                    bloodGroup == null ? "Blood Group" : "    $bloodGroup",
                    style: GoogleFonts.zillaSlab(
                      color: Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  items: <String>['A', 'B', 'AB', 'O'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      bloodGroup = value!;
                    });
                  },
                ),
              ),
              Visibility(
                visible: bloodGroup == null ? false : true,
                child: Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      left: size.width * 0.024,
                      right: size.width * 0.024),
                  child: DropdownButton<String>(
                    iconEnabledColor: primaryClr,
                    isExpanded: true,
                    elevation: 2,
                    hint: bloodGroupValue == null
                        ? Text(
                            "Positive or Negative",
                            style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          )
                        : Text(
                            "  $bloodGroupValue",
                            style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                    items: <String>["+", "-"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        bloodGroupValue = value!;
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Select a Gender:",
                      style: GoogleFonts.zillaSlab(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.04),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Male",
                          style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.05),
                        ),
                        Radio(
                          value: "Male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value as String;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Female",
                          style: GoogleFonts.zillaSlab(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.05),
                        ),
                        Radio(
                          value: "Female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value as String;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              picState? InkWell(
                onTap: () {
               getChildImage(context, size);
                },
                child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.025),
                    alignment: Alignment.center,
                    height: size.height * 0.06,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: primaryDarkClr,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "$uploadImageBtnTxt",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.045),
                    )),
              ): Container(
                margin: EdgeInsets.only(top: size.height*0.01),
                height: size.height * 0.22,
                child:  Provider.of<AUthProvider>(context,listen: false).imageFileChildGet()!= null
                    ? Image.file(Provider.of<AUthProvider>(context,listen: false).imageFileChildGet())
                    :Container(),
              ),
              InkWell(
                onTap: () {
                  signUp(context);
                },
                child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.025),
                    alignment: Alignment.center,
                    height: size.height * 0.06,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: primaryDarkClr,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.045),
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  checkError(int code, String text) {
    if (code == 1) {
      if (text.length < 2) {
        setState(() {
          errorOnNm = "Name is short";
          _error = "Name is short";
        });
      } else {
        setState(() {
          errorOnNm = null;
        });
      }
    } else if (code == 2) {
      if (![3, 4, 5, 6, 7, 8].toString().contains(text)) {
        setState(() {
          errorOnAge = "Age is not valid";
          _error = "Age is not valid";
        });
      } else {
        setState(() {
          errorOnAge = null;
          _error = null;
        });
      }
    }
  }

  signUp(BuildContext context) async {
    if (bloodGroupValue != null &&
        errorOnAge == null &&
        errorOnNm == null &&
        _controller.text.isNotEmpty &&
        childsAge != null &&
        gender != null &&
        Provider.of<AUthProvider>(context,listen: false).imageFileChildGet() != null){
      var data = await Authentication().signUpWithEmailAndPasswords(
          email: widget.email.toString().replaceAll(" ", ""),
          password: widget.password.toString().replaceAll(" ", ""),
          context: context);
      if (data != null) {
        Map<String, dynamic> map = {
          "fName": widget.fName,
          "mName": widget.mName,
          "phnNum": widget.phnNum,
          "fCNIC": widget.fCNIC,
          "mCNIC": widget.mCNIC,
          "homeAd": widget.homeAddress,
          "officialAd": widget.officialAddress,
          "email": widget.email,
          "password": widget.password,
          "childName": _controller.text.toString(),
          "childAge": childsAge,
          "bloodGroup": "$bloodGroup $bloodGroupValue"
        };
        Storage().signUpDataToFireStore(map);
        uploadImageToFireStore(context);
        // final snackBar = SnackBar(
        //   content: const Text(
        //     "Check your email Box",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        //   ),
        //   duration: const Duration(seconds: 1, milliseconds: 500),
        //   backgroundColor: primaryDarkClr,
        // );
        Fluttertoast.showToast(msg: 'Check your email Box',textColor: Colors.white,backgroundColor: primaryDarkClr);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
     Fluttertoast.showToast(msg: Provider.of<AUthProvider>(context, listen: false).signUpErrorGet(),
     backgroundColor: primaryDarkClr,textColor: Colors.white);
      }
    } else {
      Fluttertoast.showToast(msg: 'Something is missing',textColor: Colors.white,
      backgroundColor: primaryDarkClr);

    }
  }

  late firebase_storage.Reference refParent;
  late firebase_storage.Reference refChild;

  uploadImageToFireStore(BuildContext _buildContext) async {
    refParent = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users").child(FirebaseAuth.instance.currentUser!.uid)
        .child(FirebaseAuth.instance.currentUser!.uid + "parent");

    refChild = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users").child(FirebaseAuth.instance.currentUser!.uid)
        .child(FirebaseAuth.instance.currentUser!.uid + "child");

    refParent
        .putFile(Provider.of<AUthProvider>(context,listen: false).imageFileGet() as File)
        .whenComplete(() {
          print("Parent pic uploaded");
    });

    refChild
        .putFile(Provider.of<AUthProvider>(context,listen: false).imageFileChildGet())
        .whenComplete(() {
      print("Child pic uploaded");

    });
    if (Provider.of<AUthProvider>(_buildContext,listen: false).imageFileGet() != null) {
      refParent
          .putFile(Provider.of<AUthProvider>(_buildContext,listen: false).imageFileGet() as File)
          .whenComplete(() {
      }).catchError((onError) {});
    }
  }
}
