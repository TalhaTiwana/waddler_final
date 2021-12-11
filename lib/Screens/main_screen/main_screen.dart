import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Screens/Auth/login_screen.dart';
import 'package:waddler/Screens/ChatMedium/chat_medium.dart';
import 'package:waddler/Screens/GPSTracking/gps-tracking.dart';
import 'package:waddler/Screens/Home/weather_screen.dart';
import 'package:waddler/Screens/LiveSurveillance/live_surveillance.dart';
import 'package:waddler/Screens/OnlinePayment/online_payment.dart';
import 'package:waddler/Screens/Profile/profile.dart';
import 'package:waddler/Screens/faq/faq.dart';
import 'package:waddler/Screens/fetching_daycare_centers/fetching_daycare_centers.dart';
import 'package:waddler/Screens/settings/settings_screen.dart';
import 'package:waddler/Style/colors.dart';
import 'package:web_socket_channel/io.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgets = [
    const WeatherScreen(),
    const FDC(),
    Chat(),
    const Profile(),
    Surveillance(
      channel: IOWebSocketChannel.connect('ws://34.131.222.72:65080'),
    ),
    const OnlinePayment(),
    const FAQ(),
    const SettingsScreen()
  ];

  List<String> images = [
    'images/main_screen/weather_icon.png',
    'images/main_screen/daycare_center.png',
    'images/main_screen/robot.png',
    'images/main_screen/profile.png',
    'images/main_screen/live.png',
    'images/main_screen/online_payment.png',
    'images/main_screen/faq.png',
    'images/settings.png',
    'images/main_screen/logout.png',
  ];

  List<String> titles = [
    'Weather',
    'Daycare \ncenter',
    'Chat',
    'Profile',
    'Live',
    'Online \nPayment',
    'F.A.Q',
    'Settings',
        'Logout'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "Welcome Back!",
                style: GoogleFonts.cabin(
                  color: Colors.black,
                  fontSize: size.width * 0.075,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Expanded(
                child: AnimationLimiter(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    children: List.generate(
                      titles.length,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: InkWell(
                                onTap: () {
                                  if (index == 8) {
                                    _showDialog(size, context);
                                  } else {
                                    screenPush(context, widgets[index]);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: index % 2 != 0 ? 6 : 0,
                                      right: index % 2 == 0 ? 6 : 0,
                                      top: 6,
                                      bottom: 6),
                                  width: size.width * 0.4,
                                  height: size.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: primaryClrLightTheme,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.04),
                                        width: size.width * 0.3,
                                        child: Text(
                                          titles[index],
                                          style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.width * 0.06,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      Container(
                                        child: Image.asset(images[index]),
                                        width: size.width * 0.3,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
}
