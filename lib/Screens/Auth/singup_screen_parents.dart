import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Screens/Auth/singup_screen_child.dart';
import 'package:waddler/Style/colors.dart';

import 'Components/custom_text_field.dart';

class SignUpScreenParents extends StatefulWidget {
  const SignUpScreenParents({Key? key}) : super(key: key);

  @override
  _SignUpScreenParentsState createState() => _SignUpScreenParentsState();
}

class _SignUpScreenParentsState extends State<SignUpScreenParents> {



  final imagePicker = ImagePicker();
  var imagePath1;
  var image1;
  String? link1;
  String? buttonText;

  Future getImage(BuildContext _buildContext,Size size) async {
    image1 = await imagePicker.getImage(
        preferredCameraDevice: CameraDevice.front, source: ImageSource.gallery);
    Provider.of<AUthProvider>(_buildContext,listen: false).imageFileSet(File(image1.path));
    setState(() {
      imagePath1 = image1.path;

    });
    settingModalBottomSheetAddress(_buildContext, size);
  }

  final TextEditingController _controllerFName = TextEditingController();
  final TextEditingController _controllerMName = TextEditingController();
  final TextEditingController _controllerPhn = TextEditingController();
  final TextEditingController _controllerFCNIC = TextEditingController();
  final TextEditingController _controllerMCNIC = TextEditingController();
  final TextEditingController _controllerHomeAddress = TextEditingController();
  final TextEditingController _controllerOffAddress = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? errorOnFatherNm;
  String? errorOnMotherNm;
  String? errorOnPhn;
  String? errorOnFCNIC;
  String? errorOnMCNIC;
  String? errorOnHomeAddress;
  String? errorOnOffAddress;
  String? errorOnEmailAddress;

  String? errorOnPass;
  String? error;
  late bool state;
  late bool uploadButtonState;
  @override
  void initState() {
    super.initState();
    state = true;
    uploadButtonState = true;

    buttonText = "Upload parent Image";

  }

  @override
  Widget build(BuildContext context) {
    if(state){
      File? file;
      Future.delayed(const Duration(seconds: 2),(){
        Provider.of<AUthProvider>(context,listen: false).imageFileSet(file);
        setState(() {
          state = false;
        });
      });

    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
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
        height: size.height,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.03, top: size.height * 0.05),
                  child: Text(
                    "Create An Account",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.black,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8),
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.03, top: size.height * 0.02),
                  child: Text(
                    "Parent's Info",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.black,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                  )),
              CustomTextField(
                controller: _controllerFName,
                hintText: "Father's Name",
                prefixIcon: Icons.person,
                keyBoardType: TextInputType.text,
                errorText: errorOnFatherNm,
                onChange: (value) {
                  errorCheck(1, value);
                },
              ),
              CustomTextField(
                controller: _controllerMName,
                hintText: "Mother's Name",
                errorText: errorOnMotherNm,
                prefixIcon: Icons.person,
                keyBoardType: TextInputType.text,
                onChange: (value) {
                  errorCheck(2, value);
                },
              ),
              CustomTextField(
                controller: _controllerPhn,
                hintText: "Phone Number",
                errorText: errorOnPhn,
                prefixIcon: Icons.phone,
                keyBoardType: TextInputType.number,
                onChange: (value) {
                  errorCheck(3, value);
                },
              ),
              CustomTextField(
                controller: _controllerFCNIC,
                hintText: "Father's CNIC",
                errorText: errorOnFCNIC,
                prefixIcon: Icons.credit_card_rounded,
                keyBoardType: TextInputType.datetime,
                onChange: (value) {
                  errorCheck(4, value);
                },
              ),
              CustomTextField(
                controller: _controllerMCNIC,
                hintText: "Mother's CNIC",
                errorText: errorOnMCNIC,
                prefixIcon: Icons.credit_card_rounded,
                keyBoardType: TextInputType.datetime,
                onChange: (value) {
                  errorCheck(5, value);
                },
              ),
              CustomTextField(
                controller: _controllerHomeAddress,
                hintText: "Home Address",
                errorText: errorOnHomeAddress,
                prefixIcon: Icons.location_on,
                keyBoardType: TextInputType.streetAddress,
                onChange: (value) {
                  errorCheck(6, value);
                },
              ),
              CustomTextField(
                controller: _controllerOffAddress,
                hintText: "Official Address",
                errorText: errorOnOffAddress,
                prefixIcon: Icons.location_on,
                keyBoardType: TextInputType.text,
                onChange: (value) {
                  errorCheck(7, value);
                },
              ),
              CustomTextField(
                controller: _controllerEmail,
                hintText: "Email",
                errorText: errorOnEmailAddress,
                prefixIcon: Icons.email,
                keyBoardType: TextInputType.emailAddress,
                onChange: (value) {
                  errorCheck(8, value);
                },
              ),
              CustomTextField(
                controller: _controllerPassword,
                hintText: "Password",
                errorText: errorOnPass,
                prefixIcon: Icons.vpn_key_rounded,
                keyBoardType: TextInputType.text,
                onChange: (value) {
                  errorCheck(9, value);
                },
              ),
              InkWell(
                onTap:uploadButtonState? () {
                  getImage(context,size);

                }:null,
                child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.025,
                        left: size.width * 0.01,
                        right: size.width * 0.01),
                    alignment: Alignment.center,
                    height: size.height * 0.058,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          top: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        )),
                    child: Text(
                      "$buttonText",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.045),
                    )),
              ),
              InkWell(
                onTap: () {
                  continueToNext(context);
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
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  errorCheck(int code, String text) {
    if (code == 1) {
      if (text.length < 3) {
        setState(() {
          errorOnFatherNm = "Father's name is short";
          error = "Father's name is short";
        });
      } else {
        setState(() {
          errorOnFatherNm = null;
        });
      }
    } else if (code == 2) {
      if (text.length < 3) {
        setState(() {
          errorOnMotherNm = "Mother's name is short";
          error = "Mother's name is short";
        });
      } else {
        setState(() {
          errorOnMotherNm = null;
        });
      }
    } else if (code == 3) {
      if (text.length < 11) {
        setState(() {
          errorOnPhn = "Phone number is short";
          error = "Phone number is short";
        });
      } else if( text.length > 11) {
        setState(() {
          errorOnPhn = "Phone number is wrong";
          error = "Phone number is wrong";
        });
      }else{

        setState(() {
          errorOnPhn = null;
        });
      }
    } else if (code == 4) {
      if (text.length < 13) {
        setState(() {
          errorOnFCNIC = "Father's CNIC is short";
          error = "Father's CNIC is short";
        });
      } else if (text.length > 13) {
        setState(() {
          errorOnFCNIC = "Father's CNIC is wrong";
          error = "Father's CNIC is wrong";
        });
      } else {
        setState(() {
          errorOnFCNIC = null;
        });
      }
    } else if (code == 5) {
      if (text.length < 13) {
        setState(() {
          errorOnMCNIC = "Mother's CNIC is short";
          error = "Mother's CNIC is short";
        });
      } else if (text.length > 13) {
        setState(() {
          errorOnMCNIC = "Mother's CNIC is wrong";
          error = "Mother's CNIC is wrong";
        });
      } else if(text == _controllerFCNIC.text) {
        setState(() {
          errorOnMCNIC = "Mother's CNIC should not same the Father's CNIC";
          error = "Mother's CNIC is wrong";
        });
      }else{
          setState(() {
            errorOnMCNIC = null;
          });
        }

    } else if (code == 6) {
      if (text.length < 10) {
        setState(() {
          errorOnHomeAddress = "Home address is short";
          error = "Home address is short";
        });
      } else {
        print("errorOnHomeAddress");
        setState(() {
          errorOnHomeAddress = null;
        });
      }
    } else if (code == 7) {
      if (text.length < 10) {
        setState(() {
          errorOnOffAddress = "Official address is short";
          error = "Home address is short";
        });
      } else {
        setState(() {
          errorOnOffAddress = null;
        });
      }
    } else if (code == 8) {
      if (!EmailValidator.validate(text)) {
        setState(() {
          errorOnEmailAddress = "Email address is not valid";
          error = "Email address is not valid";
        });
      } else {
        setState(() {
          errorOnEmailAddress = null;
        });
      }
    } else if (code == 9) {
      if (text.length < 6) {
        setState(() {
          errorOnPass = "Password is short";
          error = "Password is short";
        });
      } else {
        setState(() {
          errorOnPass = null;
          print(error);
        });
      }
    }
  }

  continueToNext(BuildContext context) {
    if (errorOnMCNIC == null &&
        errorOnFCNIC == null &&
        errorOnFatherNm == null &&
        errorOnMotherNm == null &&
        errorOnPhn == null &&
        errorOnHomeAddress == null &&
        errorOnOffAddress == null &&
        errorOnEmailAddress == null &&
        errorOnPass == null &&
        _controllerEmail.text.isNotEmpty &&
        _controllerFCNIC.text.isNotEmpty &&
        _controllerFName.text.isNotEmpty &&
        _controllerHomeAddress.text.isNotEmpty &&
        _controllerMCNIC.text.isNotEmpty &&
        _controllerMName.text.isNotEmpty &&
        _controllerOffAddress.text.isNotEmpty &&
        _controllerPassword.text.isNotEmpty &&
        _controllerPhn.text.isNotEmpty &&
        Provider.of<AUthProvider>(context,listen: false).imageFileGet()!=null){
      screenPush(
          context,
          SignUpScreenChild(
              email: _controllerEmail.text,
              fCNIC: _controllerFCNIC.text,
              fName: _controllerFName.text,
              homeAddress: _controllerHomeAddress.text,
              mCNIC: _controllerMCNIC.text,
              mName: _controllerMName.text,
              officialAddress: _controllerOffAddress.text,
              password: _controllerPassword.text,
              phnNum: _controllerPhn.text));
    } else {
      print("errorOnMCNIC $errorOnMCNIC \n errorOnFCNIC $errorOnFCNIC"
          " errorOnFatherNm $errorOnFatherNm errorOnMotherNm $errorOnMotherNm"
          " errorOnPhn $errorOnPhn errorOnHomeAddress $errorOnHomeAddress"
          " errorOnOffAddress $errorOnOffAddress errorOnEmailAddress $errorOnEmailAddress"
          " errorOnPass $errorOnPass");

      if (error == null) {
        Fluttertoast.showToast(msg:'Info is required',textColor: Colors.white,backgroundColor: Colors.red.shade900 );

      } else {
        if(  Provider.of<AUthProvider>(context,listen: false).imageFileGet()==null){
          Fluttertoast.showToast(msg:'Please select parent image',textColor: Colors.white,backgroundColor: Colors.red.shade900 );


        }else{
          Fluttertoast.showToast(msg:'$error',textColor: Colors.white,backgroundColor: Colors.red.shade900 );
        }

      }
    }
  }

settingModalBottomSheetAddress(BuildContext context, Size size) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: size.height * 0.4,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(right: size.width * 0.03),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(13.0),
                      topRight: const Radius.circular(13.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height*0.01),
                    height: size.height * 0.22,
                    child:  Provider.of<AUthProvider>(context,listen: false).imageFileGet()!= null
                        ? Image.file(Provider.of<AUthProvider>(context,listen: false).imageFileGet() as File)
                        :link1!=null? Image.network(link1!):Container(),
                  ),

                  SizedBox(
                    height: size.height*0.02,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        buttonText = "Selected";
                        uploadButtonState = false;
                      });
                      Navigator.pop(context);
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
                          "Okay",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.045),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

}
