import 'dart:convert';
import 'dart:io';

// import 'package:color_challenge/test.dart';
import 'package:a1_ads/controller/full_time_page_con.dart';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/main_screen_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/controller/upi_controller.dart';
import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/full_time_repo.dart';
import 'package:a1_ads/data/repository/home_repo.dart';
import 'package:a1_ads/data/repository/main_repo.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/data/repository/upi_repo.dart';
import 'package:a1_ads/test.dart';
import 'package:a1_ads/view/screens/login/loginMobile.dart';
import 'package:a1_ads/view/screens/login/mainScreen.dart';
import 'package:a1_ads/view/screens/login/otpVerfication.dart';
import 'package:a1_ads/view/screens/upi_screen/wallet.dart';
import 'package:device_info/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'view/screens/profile_screen/new_profile_screen.dart';
import 'view/screens/updateApp/updateApp.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info/device_info.dart' as device_info;

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
  Get.put(const FlutterSecureStorage());
  if (kIsWeb) {
    debugPrint("The app is running on the web.");
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBnBf0EAqIe6QL7aeO9yC6dd-yHI5mI9hc",
        authDomain: "color-challenge-524cd.firebaseapp.com",
        projectId: "color-challenge-524cd",
        storageBucket: "color-challenge-524cd.appspot.com",
        messagingSenderId: "766073031164",
        appId: "1:766073031164:web:71aeb12543c06f15420a79",
        measurementId: "G-SZPYEKQ7WJ",
      ),
    );
    await storeLocal.write(key: Constant.IS_WEB, value: 'true');
  } else {
    debugPrint("The app is running on an Android device.");
    await storeLocal.write(key: Constant.IS_WEB, value: 'false');
  }

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

  Get.put(
    HomeController(
      homeRepo: HomeRepo(
          apiClient: ApiClient(
              appBaseUrl: Constant.MainBaseUrl, storageLocal: storeLocal),
          storageLocal: storeLocal),
    ),
  );

  Get.put(
    PCC(
      shortsVideoRepo: ShortsVideoRepo(
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          ),
          storageLocal: storeLocal),
    ),
  );

  Get.put(
    MainController(
      mainRepo: MainRepo(
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          ),
          storageLocal: storeLocal),
    ),
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle incoming message when the app is in the foreground
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
  });

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    // Handle incoming message when the app is in the background or terminated
    print('Handling a background message: ${message.messageId}');
  });

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
  String? _deviceId;

  @override
  void initState() {
    super.initState();
    final isLaptop = isOpenLap();
    if (isLaptop == 'true') {
      // Laptop
      print('User is on a laptop');
    } else {
      // Mobile
      print('User is on Android');
    }

    Utils().deviceInfo();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        FirebaseAnalytics.instance.logEvent(name: "appStart");
        _prefs = prefs;
      });
    });

    getAppVersion();

    FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(
          () {
            _fcmToken = token!;
          },
        );
        print('FCM Token: $_fcmToken');
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
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
            },
          );
        }
      },
    );
  }

  // String isOpenLap() {
  //   if (!kIsWeb) {
  //     return 'false'; // Running on a non-web platform (e.g., Android)
  //   } else {
  //     return 'true'; // Running in a web-based environment
  //   }
  // }

  String isOpenLap() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'false';
    } else {
      return 'true';
    }
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      var url = Constant.APPUPDATE_URL;
      Map<String, dynamic> bodyObject = {
        Constant.APP_VERSION: appVersion,
      };

      String jsonString = await apiCall(url, bodyObject);
      final Map<String, dynamic> responseJson = jsonDecode(jsonString);

      // Check if the 'data' key exists and is a List
      if (responseJson['data'] is List) {
        final dataList = responseJson['data'] as List;

        if (dataList.isNotEmpty) {
          final datass = dataList.first;
          setState(() {
            link = datass[Constant.LINK];
            update = responseJson["success"];
          });
        } else {
          // Handle empty dataList
        }
      } else {
        // Handle cases where 'data' is not a List
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print("Error: $e");
    }
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
                        storageLocal: storeLocal,
                      ),
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
              Get.put(
                MainController(
                  mainRepo: MainRepo(
                      apiClient: ApiClient(
                        appBaseUrl: Constant.MainBaseUrl,
                        storageLocal: storeLocal,
                      ),
                      storageLocal: storeLocal),
                ),
              );
              Get.put(
                FullTimePageCont(
                  fullTimeRepo: FullTimeRepo(
                      apiClient: ApiClient(
                          appBaseUrl: Constant.MainBaseUrl,
                          storageLocal: storeLocal),
                      storageLocal: storeLocal),
                ),
              );
              Get.put(
                UPIController(
                  upiRepo: UPIRepo(
                      apiClient: ApiClient(
                          appBaseUrl: Constant.MainBaseUrl,
                          storageLocal: storeLocal),
                      storageLocal: storeLocal),
                ),
              );
            }),
            // home: screens(prefs, update, link),
            // ca65ae48b1a00e20e4d2c81cc87f50de
            // b7512f3a7251c50a1737b614cf78d929
            // home: LoginMobile(),
            home: isOpenLap() != 'true'
                ? screens(prefs, update, link)
                : const Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: Text("This website is for mobile only"),
                    ),
                  ),
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
