import 'package:flutter/material.dart';

import 'login/otpVerfication.dart';

class AppRoutes {
  static const String initial = '/';
  static const String otpVerification = '/otp_verification';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case otpVerification:
        final mobileNumber = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpVerification(mobileNumber: mobileNumber));
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Text('Not found')));
    }
  }
}
