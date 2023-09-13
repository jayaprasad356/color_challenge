import 'package:color_challenge/util/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortsUpload extends StatefulWidget {
  const ShortsUpload({super.key});

  @override
  State<ShortsUpload> createState() => _ShortsUploadState();
}

class _ShortsUploadState extends State<ShortsUpload> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Upload Shorts",
          style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: colors.white,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shorts URL",
            style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            style: TextStyle(fontFamily: 'MontserratBold', color: colors.black),
            decoration: InputDecoration(
              hintText: "Enter your shorts URL.",
              hintStyle: TextStyle(fontFamily: 'MontserratBold', color: colors.black12),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: ()  {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 40,
                width: 140,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/btnbg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: const Center(
                  child: Text(
                    'Upload',
                    style: TextStyle(
                        color: colors.white,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.2,),
        ],
        ),
      ),
    );
  }
}
