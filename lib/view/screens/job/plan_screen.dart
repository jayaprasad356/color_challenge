import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/job/a1_all_job.dart';
import 'package:a1_ads/view/screens/job/a1_uploaaded_job.dart';
import 'package:a1_ads/view/screens/job/job_detail.dart';
import 'package:a1_ads/view/screens/job/my_team.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF444BBA),
                    Color(0xFF070C5C),
                  ],
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: const Text(
                'Basic Package',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MontserratBold',
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: double.infinity,
                    width: size.height * 0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    margin: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 5, right: 10),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            "assets/images/applogo.jpeg",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: size.height * 0.17,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Validity : 60 Days',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MontserratMedium',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 30,
                            width: size.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: const Text(
                              'Join now',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Package Cost',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Daily Income',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Total Income',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Refer bonus',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Level income',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Rs. 60',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Rs. 60',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Rs. 60',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Rs. 60',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Rs. 60',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
