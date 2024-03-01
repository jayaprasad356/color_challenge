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

class _MyTeamState extends State<MyTeam> with SingleTickerProviderStateMixin  {
  late TabController tabController;
  late SharedPreferences prefs;
  String gender = "";

  final selectedColor = Colors.white;
  final tabs = [
    const Tab(text: 'B-10% Bonus',),
    const Tab(text: 'C-5% Bonus',),
    const Tab(text: 'D-2% Bonus',),
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      gender = prefs.getString(Constant.GENDER)!;
    });
    tabController = TabController(length: tabs.length, vsync: this);
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
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        title: const Text(
          "My Team",
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
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                  const Column(
                    children: [
                      Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Team Size',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.purpleAccent,
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
                  const Column(
                    children: [
                      Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Valid Team',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.5,
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
                      physics: const BouncingScrollPhysics(),
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
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
                          // if (index == 0) {
                          //   jobCon.allJobs();
                          // } else if (index == 1) {
                          //   jobCon.usersJoinedJobs();
                          // }
                        });
                      },
                    ),
                  ),
                  Container(
                    height: size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFFFFFF),
                    ),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '70********83',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'MontserratMedium',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Register Date',
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
                                  '2024-01-01',
                                  style: TextStyle(
                                    color: colors.primary_color,
                                    fontFamily: 'MontserratBold',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Referrer',
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
                                  '11',
                                  style: TextStyle(
                                    color: colors.primary_color,
                                    fontFamily: 'MontserratBold',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Assets',
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
                                  '202.00',
                                  style: TextStyle(
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
                  ),
                  Container(
                    height: size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFFFFFF),
                    ),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '70********83',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'MontserratMedium',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Register Date',
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
                                  '2024-01-01',
                                  style: TextStyle(
                                    color: colors.primary_color,
                                    fontFamily: 'MontserratBold',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Referrer',
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
                                  '11',
                                  style: TextStyle(
                                    color: colors.primary_color,
                                    fontFamily: 'MontserratBold',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Assets',
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
                                  '202.00',
                                  style: TextStyle(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
