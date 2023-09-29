import 'dart:convert';

// import 'package:color_challenge/test.dart';
import 'package:color_challenge/controller/home_controller.dart';
import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/data/repository/home_repo.dart';
import 'package:color_challenge/data/repository/shorts_video_repo.dart';
import 'package:color_challenge/test.dart';
import 'package:color_challenge/view/screens/login/loginMobile.dart';
import 'package:color_challenge/view/screens/login/mainScreen.dart';
import 'package:color_challenge/view/screens/login/otpVerfication.dart';
import 'package:color_challenge/view/screens/upi_screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'util/Constant.dart';
import 'Helper/apiCall.dart';
import 'controller/utils.dart';
import 'package:package_info/package_info.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'view/screens/updateApp/updateApp.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: FirebaseOptions(
  //   apiKey: "AIzaSyBnBf0EAqIe6QL7aeO9yC6dd-yHI5mI9hc",
  //   appId: "1:766073031164:web:7ce16b7d99a4ed8c420a79",
  //   messagingSenderId: "766073031164",
  //   projectId: "color-challenge-524cd",
  // ),);
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

  Get.put(const FlutterSecureStorage());

  // runApp(MyVideoApp());
  runApp(const MyApp());
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
  bool update = true;
  String link = "";

  @override
  void initState() {
    super.initState();
    Utils().deviceInfo();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        FirebaseAnalytics.instance.logEvent(name: "appStart");
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
      //showNotification();
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

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    var url = Constant.APPUPDATE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.APP_VERSION: appVersion,
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final jsonData = jsonDecode(jsonString);
    final dataList = jsonData['data'] as List;
    final datass = dataList.first;

    setState(() {
      link = datass[Constant.LINK];
      update = responseJson["success"];
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
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'A1 Ads',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/otpVerification': (context) => const OtpVerification(
                    mobileNumber: '',
                    otp: '',
                  ),
            },
            initialBinding: BindingsBuilder(() {
              Get.put(
                PCC(
                  shortsVideoRepo: ShortsVideoRepo(
                      apiClient: ApiClient(
                          appBaseUrl: Constant.MainBaseUrl,
                          storageLocal: storeLocal),
                      storageLocal: storeLocal),
                ),
              );
              Get.put(
                HomeController(
                  homeRepo: HomeRepo(
                      apiClient: ApiClient(
                          appBaseUrl: Constant.MainBaseUrl,
                          storageLocal: storeLocal),
                      storageLocal: storeLocal),
                ),
              );
            }),
            // home: wallet(),
            home: screens(prefs, update, link),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

Widget screens(SharedPreferences prefs, bool update, String link) {
  final String? isLoggedIn = prefs.getString(Constant.LOGED_IN);
  if (isLoggedIn != null && isLoggedIn == "true") {
    // showNotification();
    if (update) {
      return const MainScreen();
    } else {
      return UpdateDialog(link: link);
    }
  } else {
    if (update) {
      return const LoginMobile();
    } else {
      return UpdateDialog(link: link);
    }
  }
}

// void showNotification() {
//   flutterLocalNotificationsPlugin.show(
//       0,
//       "Testing Notification",
//       "This notification comes all the time of opening app",
//       NotificationDetails(
//           android: AndroidNotificationDetails(channel.id, channel.name,
//               channelDescription: channel.description,
//               importance: Importance.high,
//               color: Colors.blue,
//               priority: Priority.high,
//               playSound: true,
//               icon: '@mipmap/ic_launcher')));
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(),
//     );
//   }
// }
