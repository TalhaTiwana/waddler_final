import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waddler/CareCenterList.dart';
import 'package:waddler/Help.dart';
import 'package:waddler/notification.dart';
import 'package:waddler/Settings.dart';
import 'package:waddler/main.dart';

class FeedbackApp extends StatelessWidget {
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
                    image: DecorationImage(image: AssetImage("assets/img.png"),fit: BoxFit.cover)
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text("DayCare Centers"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> CareCenterList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text("Notification"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> NotificationApp()));

              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> Settings()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> Help()));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> FeedbackApp()));
              },
            ),
          ],
        ),
      ),
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Contact Us"),
              Text("Leave us a message, and we'll get in contact with you as soon as possible."),
              TextField(
                decoration: InputDecoration(
                  hintText: "Your Name",
                  labelText: "Name",
                  icon: Icon(Icons.person),

                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your message",
                  labelText: "Message",
                  icon: Icon(Icons.message),
                ),
              ),
              Container(
                child: Text("You can report bugs and errors in the application. We'll try to resolve them."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
