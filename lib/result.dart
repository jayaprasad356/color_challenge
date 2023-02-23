import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'myResults.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyResults()
    );
  }
}
