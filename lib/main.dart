import 'dart:convert';

import 'package:color_challenge/login/loginMobile.dart';
import 'package:color_challenge/login/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'login/otpVerfication.dart';
import 'package:package_info/package_info.dart';

import 'updateApp.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
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
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  late String _fcmToken;
  late String appVersion;
   bool update=true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });

    getAppVersion();

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _fcmToken = token!;
      });
      print('FCM Token: $_fcmToken');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage received: $message');
      showNotification();
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
                channelDescription: channel.description!,
                importance: channel.importance!,
                playSound: channel.playSound!,
                color: Colors.blue,
                priority: Priority.high,
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
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          final SharedPreferences prefs = snapshot.data!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/otpVerification': (context) => OtpVerification(
                    mobileNumber: '',
                  ),
            },
            home: screens(prefs, update),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    var url = Constant.APPUPDATE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.APP_VERSION: appVersion,
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    setState(() {
      update = responseJson["success"];
    });

  }
}

Widget screens(
  SharedPreferences prefs,
  bool update,
) {
  final String? isLoggedIn = prefs.getString(Constant.LOGED_IN);
  if (isLoggedIn != null && isLoggedIn == "true") {
    // showNotification();
    if (update) {
      return const MainScreen();
    } else {
      return  UpdateDialog();
    }
  } else {
    return const LoginMobile();
  }
}

void showNotification() {
  flutterLocalNotificationsPlugin.show(
      0,
      "Testing Notification",
      "This notification comes all the time of opening app",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              color: Colors.blue,
              priority: Priority.high,
              playSound: true,
              icon: '@mipmap/ic_launcher')));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
