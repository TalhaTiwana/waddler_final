import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Screens/SplashScreen/splash_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MultiProvider(providers: [
ChangeNotifierProvider(create:(_)=>AUthProvider())
    ],
    child: Waddler(),
    )
  );
}

class Waddler extends StatefulWidget {
  const Waddler({Key? key}) : super(key: key);

  @override
  State<Waddler> createState() => _WaddlerState();
}

class _WaddlerState extends State<Waddler> {

  late FirebaseMessaging messaging;



 @override
  void initState() {
   super.initState();

   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
     RemoteNotification? notification = message.notification;
     AndroidNotification? android = message.notification?.android;
     if (notification != null && android != null) {
       flutterLocalNotificationsPlugin.show(
           notification.hashCode,
           notification.title,
           notification.body,
           NotificationDetails(
             android: AndroidNotificationDetails(
               channel.id,
               channel.name,
               channel.description,
               color: Colors.blue,
               playSound: true,
               icon: '@mipmap/ic_launcher',
             ),
           ));
     }
   });

   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     print('A new onMessageOpenedApp event was published!');
     RemoteNotification? notification = message.notification;
     AndroidNotification? android = message.notification?.android;
     if (notification != null && android != null) {
       showDialog(
           context: context,
           builder: (_) {
             return AlertDialog(
               title: Text(notification.title.toString()),
               content: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [Text(notification.body.toString())],
                 ),
               ),
             );
           });
     }
   });

  }


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }


}
