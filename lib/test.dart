import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to A1 Ads",
          style: TextStyle(
              fontSize: 24,
              color: colors.primary,
              fontFamily: 'MontserratBold',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

