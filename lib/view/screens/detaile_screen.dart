import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SharedPreferences prefs;
  String name = "";
  String refer_code = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      // referText = prefs.getString(Constant.REFER_CODE)!;
      // refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      setState(() {
        name = prefs.getString(Constant.NAME)!;
        refer_code = prefs.getString(Constant.REFER_CODE)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.secondary_color,
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
          "Details of Ads and Earning",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: colors.white,
            fontSize: 18,
          ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Set width to the screen width
          height: MediaQuery.of(context)
              .size
              .height, // Set height to the screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'MontserratBold',
                      color: colors.white,
                      fontSize: 18,
                    ),
                  ),
                          Text(
                            refer_code,
                            style: const TextStyle(
                              color: colors.white,
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  // OutlinedButton(
                  //   onPressed: () {
                  //     Utils().showToast("Copied !");
                  //     Clipboard.setData(ClipboardData(text: refer_code));
                  //   },
                  //   style: OutlinedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(6.0),
                  //       side: const BorderSide(color: colors.red),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding:
                  //     const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: <Widget>[
                  //         Image.asset(
                  //           "assets/images/copy.png",
                  //           width: 24.0,
                  //           height: 24.0,
                  //         ),
                  //         const SizedBox(width: 8.0),
                  //         Text(
                  //           refer_code,
                  //           style: const TextStyle(
                  //             color: colors.primary,
                  //             fontSize: 12.0,
                  //             fontFamily: "Montserrat",
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: size.height * 0.12,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [colors.primary_color, colors.secondary_color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: colors.widget_color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/Group 1959.png',
                        color: colors.widget_color,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today Earnings",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "1234",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.12,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [colors.primary_color, colors.secondary_color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: colors.widget_color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/Group 1960.png',
                        color: colors.widget_color,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last 7 Day Earnings",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "1234",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.12,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [colors.primary_color, colors.secondary_color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: colors.widget_color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/Group 1961.png',
                        color: colors.widget_color,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Earnings",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "1234",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.12,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [colors.primary_color, colors.secondary_color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: colors.widget_color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/Group 1964.png',
                        color: colors.widget_color,
                        width: size.width * 0.2,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Ads",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "1234",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.12,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [colors.primary_color, colors.secondary_color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: colors.widget_color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/Group 1963.png',
                        color: colors.widget_color,
                        width: size.width * 0.2,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today Ads",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "1234",
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
