import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Screens/Auth/login_screen.dart';
import 'package:waddler/Screens/ChatMedium/chat_medium.dart';
import 'package:waddler/Screens/GPSTracking/gps-tracking.dart';
import 'package:waddler/Screens/LiveSurveillance/live_surveillance.dart';
import 'package:waddler/Screens/OnlinePayment/online_payment.dart';
import 'package:waddler/Screens/Profile/profile.dart';
import 'package:waddler/Screens/faq/faq.dart';
import 'package:waddler/Screens/fetching_daycare_centers/fetching_daycare_centers.dart';
import 'package:waddler/Style/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:web_socket_channel/io.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late firebase_storage.Reference refParent;
  late firebase_storage.Reference refChild;

  String urlParentImage =
      "https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";
  String urlChildImage =
      "https://cdn.dribbble.com/users/619787/screenshots/6138946/anime_still_2x.gif?compress=1&resize=400x300";

  @override
  void initState() {
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.63,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.only(topRight:Radius.circular(50))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),
                topRight: Radius.circular(50)
                )
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  width: size.width*0.45,
                  margin: EdgeInsets.only(right: size.width*0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.width * 0.17,
                            height: size.width * 0.17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(urlParentImage),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            "Parent",
                            style: GoogleFonts.zillaSlab(
                                fontSize: size.width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: size.width * 0.17,
                            height: size.width * 0.17,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(urlChildImage),
                                    fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            "Child",
                            style: GoogleFonts.zillaSlab(
                                fontSize: size.width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.02,
                        top: size.height * 0.03,
                        bottom: size.height * 0.024),
                    width: size.width,
                    child: Text(
                      "${FirebaseAuth.instance.currentUser!.email}",
                      style: GoogleFonts.zillaSlab(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.04),
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: size.height*0.03,
          ),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, Profile());
              },
              title: "Profile",
              ),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, FDC());
              },
              title: "Daycare Center",),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, Surveillance(
channel:  IOWebSocketChannel.connect('ws://34.131.222.72:65080'),
                ));
              },
              title: "Live Surveillance",
              ),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, GPSTracking());
              },
              title: "GPS Tracking",
              ),
          drawerTile(
              size: size, onTap: ()async {
            Navigator.pop(context);
            screenPush(context, Chat());
          }, title: "Chat Medium", icon: Icons.chat),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, OnlinePayment());
              },
              title: "Online Payment",
              ),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, OnlinePayment());
              },
              title: "Configuration",
              ),
          drawerTile(
              size: size,
              onTap: () {
                Navigator.pop(context);
                screenPush(context, FAQ());
              },
              title: "FAQ",
              ),
        InkWell(
          onTap: (){
            _showDialog(size, context);
          },
          child: Container(
            margin: EdgeInsets.only(left: size.width*0.04,top: size.height*0.03),
            width: size.width*0.3,
               alignment: Alignment.center,
            height: size.height*0.06,
            decoration: BoxDecoration(
              color: Colors.black,
borderRadius: BorderRadius.circular(30)
            ),
            child: Text("Sign Out",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.width*0.043,
              color: Colors.white
            ),),
          ),
        )
        ],
      ),
    );
  }

  _showDialog(Size size, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Are you sure to logout?"),
        actions: [
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().whenComplete(() {
                Fluttertoast.showToast(msg: 'Successfully logout');

              });
              Navigator.pop(context);
              screenPushRep(context, LoginScreen());
            },
            child: Text("Yes"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          )
        ],
      ),
    );
  }

  Widget drawerTile({required Size size, IconData? icon, required String title, required onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            left: size.width * 0.04,
            top: size.height * 0.01,
            bottom: size.height * 0.02),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              "$title",
              style:
                  TextStyle(color: Colors.black, fontSize: size.width * 0.045,
                  fontWeight: FontWeight.w500
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
