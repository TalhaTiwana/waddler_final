import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Screens/Auth/Components/custom_text_field.dart';
import 'package:waddler/Style/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;
  late firebase_storage.Reference refParent;
  late firebase_storage.Reference refChild;
  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  String? error;

  final TextEditingController _controllerFatherNm = TextEditingController();
  final TextEditingController _controllerMotherNm = TextEditingController();
  final TextEditingController _controllerPhnNm = TextEditingController();
  final TextEditingController _controllerHomeAddressNm = TextEditingController();
  final TextEditingController _controllerFatherCNICNm = TextEditingController();
  final TextEditingController _controllerMotherCNICNm = TextEditingController();
  final TextEditingController _controllerOfficialNm = TextEditingController();
  final TextEditingController _controllerChildsName = TextEditingController();

  String urlParentImage =
      "https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";
  String urlChildImage =
      "https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";

  late CollectionReference _ref;

  final imagePicker = ImagePicker();
  var imagePath1;
  var image1;
  late String link1;
  late String buttonText;

  Future getImage(BuildContext _buildContext, Size size, int code) async {
    image1 = await imagePicker.getImage(
        preferredCameraDevice: CameraDevice.front, source: ImageSource.gallery);
    Provider.of<AUthProvider>(_buildContext, listen: false)
        .imageFileSet(File(image1.path));
    setState(() {
      imagePath1 = image1.path;
    });
    if (image1 != null) {
      Future.delayed(const Duration(seconds: 1), () {
        uploadImageToFireStore(buildContext: _buildContext, code: code);
        Fluttertoast.showToast(msg: 'Updated',backgroundColor: primaryDarkClr,textColor: Colors.white);

        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    _ref = _firebaseFireStore.collection("Users");
    _ref.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      _controllerFatherNm.text = value.get("fName");
      _controllerMotherNm.text = value.get("mName");
      _controllerPhnNm.text = value.get("phnNum");
      _controllerFatherCNICNm.text = value.get("fCNIC");
      _controllerMotherCNICNm.text = value.get("mCNIC");
      _controllerOfficialNm.text = value.get("officialAd");
      _controllerHomeAddressNm.text = value.get("homeAd");
      _controllerChildsName.text = value.get("childName");
    }).whenComplete(() {
      print("fetched data");
    });
    refParent = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(FirebaseAuth.instance.currentUser!.uid + "parent");
    refParent.getDownloadURL().then((value) {
      urlParentImage = value;
      setState(() {});
    });
    refChild = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(FirebaseAuth.instance.currentUser!.uid + "child");

    refChild.getDownloadURL().then((value) {
      urlChildImage = value;
      setState(() {});
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryClr,
            appBar: AppBar(
              title: Text(
                "Profile",
                style: GoogleFonts.cabin(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: primaryDarkClr,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: primaryDarkClr,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.only(bottom: size.height * 0.01),
                onTap: (value) {},
                unselectedLabelColor: Colors.white30,
                tabs: [
                  Text(
                    "Parent",
                    style: GoogleFonts.cabin(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.045),
                  ),
                  Text(
                    "Child",
                    style: GoogleFonts.cabin(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.045),
                  )
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xffFFB5EBF9),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  bottom: size.height * 0.02),
                              width: size.width * 0.25,
                              height: size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(urlParentImage),
                                  )),
                            ),
                            Positioned(
                              right: 0,
                              bottom: size.height * 0.022,
                              child: Container(
                                width: size.width * 0.08,
                                height: size.width * 0.08,
                                decoration: BoxDecoration(
                                  color: primaryDarkClr,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: size.width * 0.04,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    getImage(context, size, 1);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 1,
                                fieldRef: "fName",
                                icon: Icons.person,
                                size: size,
                                labelText: "Father's name",
                                controller: _controllerFatherNm,
                                context: context,
                              );
                            },
                          ),
                          controller: _controllerFatherNm,
                          hintText: "Father's name",
                          prefixIcon: Icons.person,
                          keyBoardType: TextInputType.text,
                          onChange: (value) {},
                        ),
                        CustomTextField(
                          controller: _controllerMotherNm,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 2,
                                fieldRef: "mName",
                                icon: Icons.person,
                                size: size,
                                labelText: "Mother's name",
                                controller: _controllerMotherNm,
                                context: context,
                              );
                            },
                          ),
                          hintText: "Mother's name",
                          prefixIcon: Icons.person,
                          keyBoardType: TextInputType.text, onChange: null,
                        ),
                        CustomTextField(
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 3,
                                fieldRef: "phnNum",
                                icon: Icons.phone,
                                size: size,
                                labelText: "Phone number",
                                controller: _controllerPhnNm,
                                context: context,
                              );
                            },
                          ),
                          hintText: "Phone number",
                          prefixIcon: Icons.phone,
                          controller: _controllerPhnNm,
                          keyBoardType: TextInputType.text, onChange: null,
                        ),
                        CustomTextField(
                          onChange: null,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 4,
                                fieldRef: "fCNIC",
                                icon: Icons.credit_card,
                                size: size,
                                labelText: "Father's CNIC",
                                controller: _controllerFatherCNICNm,
                                context: context,
                              );
                            },
                          ),
                          hintText: "Father's CNIC",
                          controller: _controllerFatherCNICNm,
                          prefixIcon: Icons.credit_card,
                          keyBoardType: TextInputType.text,
                        ),
                        CustomTextField(
                          onChange: null,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 5,
                                fieldRef: "mCNIC",
                                icon: Icons.credit_card,
                                size: size,
                                labelText: "Mother's CNIC",
                                controller: _controllerMotherCNICNm,
                                context: context,
                              );
                            },
                          ),
                          controller: _controllerMotherCNICNm,
                          hintText: "Mother's CNIC",
                          prefixIcon: Icons.credit_card,
                          keyBoardType: TextInputType.text,
                        ),
                        CustomTextField(
                          onChange: null,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 6,
                                fieldRef: "homeAd",
                                icon: Icons.location_on,
                                size: size,
                                labelText: "Home Address",
                                controller: _controllerHomeAddressNm,
                                context: context,
                              );
                            },
                          ),
                          controller: _controllerHomeAddressNm,
                          hintText: "Home Address",
                          prefixIcon: Icons.location_on,
                          keyBoardType: TextInputType.text,
                        ),
                        CustomTextField(
                          onChange: null,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 7,
                                fieldRef: "officialAd",
                                icon: Icons.location_on,
                                size: size,
                                labelText: "Official Address",
                                controller: _controllerOfficialNm,
                                context: context,
                              );
                            },
                          ),
                          controller: _controllerOfficialNm,
                          hintText: "Official Address",
                          prefixIcon: Icons.location_on,
                          keyBoardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xffFFB5EBF9),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  bottom: size.height * 0.02),
                              width: size.width * 0.25,
                              height: size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(urlChildImage),
                                  )),
                            ),
                            Positioned(
                              right: 0,
                              bottom: size.height * 0.022,
                              child: Container(
                                width: size.width * 0.08,
                                height: size.width * 0.08,
                                decoration: BoxDecoration(
                                  color: primaryDarkClr,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: size.width * 0.04,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    getImage(context, size, 2);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          onChange: null,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              settingModalBottomSheetAddress(
                                code: 9,
                                fieldRef: "childName",
                                icon: Icons.person,
                                size: size,
                                labelText: "Child's name",
                                controller: _controllerChildsName,
                                context: context,
                              );
                            },
                          ),
                          controller: _controllerChildsName,
                          hintText: "Child's Name",
                          prefixIcon: Icons.person,
                          keyBoardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  settingModalBottomSheetAddress(
      {required int code,
      var fieldRef,
      var icon,
      required String labelText,
      required BuildContext context,
      required Size size,
      required TextEditingController controller}) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            width: size.width,
            height: size.height * 0.3,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                  right: size.width * 0.03, left: size.width * 0.03),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.0),
                      topRight: Radius.circular(13.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    child: Text(
                      "Editing Mode",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  CustomTextField(
                    errorText: error,
                    hintText: labelText,
                    prefixIcon: icon,
                    controller: controller,
                    onChange: (value) {
                      errorCheck(code, value);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      if (error == null) {
                        _ref
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({"$fieldRef": controller.text});
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: '$error');
                      }
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
                        "Done",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  errorCheck(int code, String text) {
    if (code == 1) {
      if (text.length < 3) {
        setState(() {
          error = "Father's name is short";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 2) {
      if (text.length < 3) {
        setState(() {
          error = "Mother's name is short";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 3) {
      if (text.length < 11) {
        setState(() {
          error = "Phone number is short";
        });
      } else if (text.length > 11) {
        setState(() {
          error = "Phone number is wrong";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 4) {
      if (text.length < 13) {
        setState(() {
          error = "Father's CNIC is short";
        });
      } else if (text.length > 13) {
        setState(() {
          error = "Father's CNIC is wrong";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 5) {
      if (text.length < 13) {
        setState(() {
          error = "Mother's CNIC is short";
        });
      } else if (text.length > 13) {
        setState(() {
          error = "Mother's CNIC is wrong";
        });
      } else if (text == _controllerFatherCNICNm.text) {
        setState(() {
          error = "Mother's CNIC is wrong";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 6) {
      if (text.length < 10) {
        setState(() {
          error = "Home address is short";
        });
      } else {
        print("errorOnHomeAddress");
        setState(() {
          error = null;
        });
      }
    } else if (code == 7) {
      if (text.length < 10) {
        setState(() {
          error = "Official address is short";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 8) {
      if (!EmailValidator.validate(text)) {
        setState(() {
          error = "Email address is not valid";
        });
      } else {
        setState(() {
          error = null;
        });
      }
    } else if (code == 9) {
      if (text.length < 6) {
        setState(() {
          error = "Child's name is short";
        });
      } else {
        setState(() {
          error = null;
          print(error);
        });
      }
    }
  }

  uploadImageToFireStore({required BuildContext buildContext, required int code}) async {
    if (code == 1) {
      refParent = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("Users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(FirebaseAuth.instance.currentUser!.uid + "parent");

      refParent
          .putFile(Provider.of<AUthProvider>(buildContext, listen: false)
              .imageFileGet() as File)
          .whenComplete(() {
        print("Parent pic uploaded");
      });
    } else {
      refChild = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("Users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(FirebaseAuth.instance.currentUser!.uid + "child");

      refChild
          .putFile(Provider.of<AUthProvider>(buildContext, listen: false)
              .imageFileChildGet())
          .whenComplete(() {
        print("Child pic uploaded");
      });
    }
  }
}
