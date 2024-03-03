import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Color.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({Key? key}) : super(key: key);

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late SharedPreferences prefs;
  final JobCon jobCon = Get.find<JobCon>();
  String teamSize = "";
  String validTeam = "";

  final selectedColor = Colors.white;
  final tabs = [
    const Tab(
      text: 'B-10% Bonus',
    ),
    const Tab(
      text: 'C-5% Bonus',
    ),
    const Tab(
      text: 'D-2% Bonus',
    ),
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        teamSize = prefs.getString(Constant.TEAM_SIZE)!;
        validTeam = prefs.getString(Constant.VALID_TEAM)!;
        debugPrint("teamSize $teamSize");
        debugPrint("validTeam $validTeam");
      });
    });
    tabController = TabController(length: tabs.length, vsync: this);
    if (tabController.index.toString() == '0') {
      jobCon.teamList('b');
    }
    print("tabController ${tabController.index}");
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleTabSelection(int index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          Container(
            height: size.height * 0.1,
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      teamSize,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'MontserratBold',
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Team Size',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'MontserratMedium',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Text(
                      validTeam,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'MontserratBold',
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Valid Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'MontserratMedium',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF1F1F9),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFC6C8E9),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      physics: const ClampingScrollPhysics(),
                      indicatorPadding: EdgeInsets.zero,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      automaticIndicatorColorAdjustment: false,
                      indicator: BoxDecoration(
                        boxShadow: null,
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF444BBA),
                            Color(0xFF070C5C),
                          ],
                        ),
                        // border: Border(
                        //   bottom: BorderSide(
                        //     width: 50,
                        //     color: Color(0xFF161C7E),
                        //     style: BorderStyle.solid,
                        //   ),
                        // ),
                      ),
                      labelColor: const Color(0xFFFFFFFF),
                      unselectedLabelColor: const Color(0xFF242426),
                      labelStyle: const TextStyle(
                        fontFamily: 'MontserratMedium',
                        fontSize: 16,
                      ),
                      tabs: tabs,
                      onTap: (index) {
                        setState(() {
                          handleTabSelection(index);
                          if (index == 0) {
                            jobCon.teamList('b');
                          } else if (index == 1) {
                            jobCon.teamList('c');
                          } else if (index == 2) {
                            jobCon.teamList('d');
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Obx(
                          () => ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: jobCon.teamListJson.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: size.height * 0.15,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobCon.teamListJson[index].mobile,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Register Date',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .registeredDate,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Referrer',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .referrer,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Assets',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .assets,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Obx(
                          () => ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: jobCon.teamListJson.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: size.height * 0.15,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobCon.teamListJson[index].mobile,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Register Date',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .registeredDate,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Referrer',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .referrer,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Assets',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'MontserratLight',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                jobCon.teamListJson[index]
                                                    .assets,
                                                style: const TextStyle(
                                                  color: colors.primary_color,
                                                  fontFamily:
                                                      'MontserratBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: jobCon.teamListJson.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: size.height * 0.15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFFFFFFF),
                                ),
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobCon.teamListJson[index].mobile,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'MontserratMedium',
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Register Date',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'MontserratLight',
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              jobCon.teamListJson[index]
                                                  .registeredDate,
                                              style: const TextStyle(
                                                color: colors.primary_color,
                                                fontFamily: 'MontserratBold',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Referrer',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'MontserratLight',
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              jobCon.teamListJson[index]
                                                  .referrer,
                                              style: const TextStyle(
                                                color: colors.primary_color,
                                                fontFamily: 'MontserratBold',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Assets',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'MontserratLight',
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              jobCon
                                                  .teamListJson[index].assets,
                                              style: const TextStyle(
                                                color: colors.primary_color,
                                                fontFamily: 'MontserratBold',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
