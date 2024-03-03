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

class MyPlan extends StatefulWidget {
  const MyPlan({super.key});

  @override
  State<MyPlan> createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan>
    with SingleTickerProviderStateMixin {
  final JobCon jobCon = Get.find<JobCon>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobCon.userPlanList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        title: const Text(
          "My Plan",
          style: TextStyle(
            fontFamily: 'MontserratLight',
            color: Color(0xFF000000),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            'assets/images/Group 18197.png',
            height: 34,
          ),
        ),
      ),
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
            Obx(
                  () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobCon.userPlanListJson.length,
                  itemBuilder: (context, index) {
                    // debugPrint("===> j: ${jobCon.planListJson}");
                    return Container(
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
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
                                  child: Image.network(
                                    jobCon.userPlanListJson[index].image,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: size.height * 0.17,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Validity : ${jobCon.userPlanListJson[index].validity} Days',
                                      style: const TextStyle(
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
                                  child: InkWell(
                                    onTap: (){
                                      debugPrint("jobCon.userPlanListJson[index].planId: ${jobCon.userPlanListJson[index].planId}");
                                      jobCon.claim(jobCon.userPlanListJson[index].planId);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Get',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'MontserratBold',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₹${jobCon.userPlanListJson[index].price}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'MontserratMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '₹${jobCon.userPlanListJson[index].dailyIncome}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'MontserratMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '₹${jobCon.userPlanListJson[index].totalIncome}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'MontserratMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '₹${jobCon.userPlanListJson[index].inviteBonus}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'MontserratMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '₹${jobCon.userPlanListJson[index].levelIncome}',
                                          style: const TextStyle(
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
                    );
                  }),
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
