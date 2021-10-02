import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waddler/CareCenterList.dart';
import 'package:waddler/Feedback.dart';
import 'package:waddler/Help.dart';
import 'package:waddler/Settings.dart';
import 'package:waddler/main.dart';

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waddler"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Samiya Ahsan'),
              accountEmail: Text('Samiya.ahsan99@gmail.com'),
              currentAccountPicture: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: AssetImage("assets/img.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text("DayCare Centers"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CareCenterList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text("Notification"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotificationApp()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Help()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackApp()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Notification"),
            Column(
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Messages Notification"),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Calls Notification"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
