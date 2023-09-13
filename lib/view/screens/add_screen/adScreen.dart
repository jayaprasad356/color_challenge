import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset(
            "assets/images/wfh.jpg",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
