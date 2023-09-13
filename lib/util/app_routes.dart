import 'package:color_challenge/view/screens/login/otpVerfication.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String initial = '/';
  static const String otpVerification = '/otp_verification';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case otpVerification:
        final mobileNumber = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpVerification(mobileNumber: mobileNumber, otp: '',));
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Text('Not found')));
    }
  }
}
