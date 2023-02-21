import 'package:color_challenge/login/loginMobile.dart';
import 'package:color_challenge/login/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          final SharedPreferences prefs = snapshot.data!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: hjfs(prefs),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
  Widget hjfs(SharedPreferences prefs) {
    final String? isLoggedIn = prefs.getString(Constant.LOGED_IN);
    if (isLoggedIn != null && isLoggedIn == "true") {
      return const MainScreen();
    } else {
      return const LoginMobile();
    }
  }
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
