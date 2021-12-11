import 'package:flutter/material.dart';
import 'package:flutter_credit_card/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Style/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool themeStatus = false;
  bool notificationStatus = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            GetStorage().read('isDark') == true ? Colors.black : Colors.white,
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: primaryDarkClrLightTheme,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Theme mode: ',
                  style: GoogleFonts.rubik(
                      color: GetStorage().read('isDark') == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  child: FlutterSwitch(
                    width: size.width * 0.25,
                    activeColor: primaryClrDarkTheme,
                    inactiveColor: primaryClrLightTheme,
                    inactiveIcon:
                        Image.asset('images/day_mood.png', fit: BoxFit.fill),
                    activeIcon: Image.asset(
                      'images/night_mood.png',
                      fit: BoxFit.fill,
                    ),
                    height: size.height * 0.06,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    value: themeStatus,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        themeStatus = val;
                        GetStorage().write('isDark', val);
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Notification: ',
                  style: GoogleFonts.rubik(
                      color: GetStorage().read('isDark') == true
                          ? Colors.white
                          : Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  child: FlutterSwitch(
                    width: size.width * 0.25,
                    activeColor: primaryClrDarkTheme,
                    inactiveColor: primaryClrLightTheme,
                    height: size.height * 0.06,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    value: notificationStatus,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        notificationStatus = val;
                        GetStorage().write('notificationIsOn', val);
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
