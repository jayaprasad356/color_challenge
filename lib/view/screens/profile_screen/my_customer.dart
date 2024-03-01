import 'dart:convert';
import 'package:a1_ads/model/my_customer_data.dart';
import 'package:a1_ads/model/transactionl_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomer extends StatefulWidget {
  const MyCustomer({Key? key}) : super(key: key);

  @override
  State<MyCustomer> createState() => _MyCustomerState();
}

class _MyCustomerState extends State<MyCustomer> {
  late List<MyCustomerData> myCustomerData = [];
  late SharedPreferences prefs;
  late String teamSize;
  late String validTeam;
  late String levelIncome;
  late String totalAssets;
  Future<List<MyCustomerData>> _getWithdrawalsData() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      // Constant.USER_ID: '344',
      Constant.USER_ID: prefs.getString(Constant.ID)!,
    };

    debugPrint('bodyObject: $bodyObject');

    String response = await apiCall(Constant.MY_REFERS_LIST,bodyObject);

    debugPrint('response: $response');

    final jsonData = jsonDecode(response);

    debugPrint('jsonData: $jsonData');

    myCustomerData.clear();

    for (var Data in jsonData['data']) {
      final id = Data['id'];
      final mobile = Data["mobile"];
      final name = Data['name'];
      final status = Data['status'];
      final referLevelIncome = Data['refer_level_income'];

      MyCustomerData data = MyCustomerData(id, mobile, name, status, referLevelIncome);
      myCustomerData.add(data);
    }
    debugPrint('===> myCustomerData: $myCustomerData');

    return myCustomerData;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      teamSize = prefs.getString(Constant.TEAM_SIZE)!;
      debugPrint("teamSize: $teamSize");
      validTeam = prefs.getString(Constant.VALID_TEAM)!;
      debugPrint("validTeam: $validTeam");
      levelIncome = prefs.getString(Constant.LEVEL_INCOME)!;
      debugPrint("levelIncome: $levelIncome");
      totalAssets = prefs.getString(Constant.TOTAL_ASSETS)!;
      debugPrint("totalAssets: $totalAssets");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      // appBar: AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: const Color(0xFFF8F8F8),
      //   title: const Text(
      //     "My Customer",
      //     style: TextStyle(
      //       fontFamily: 'MontserratLight',
      //       color: Color(0xFF000000),
      //     ),
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: Image.asset(
      //       'assets/images/Group 18197.png',
      //       height: 34,
      //     ),
      //   ),
      // ),
      body: FutureBuilder(
        future: _getWithdrawalsData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (myCustomerData.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFE27E1C),
                              Color(0xFF851161),
                            ])),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/team-icon-teamwork.png',
                              width: double.infinity,
                              color: Color(0xFF851161),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                              vertical: size.height * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Team Size",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        teamSize,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05,),
                                      const Text(
                                        "Level Income",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        levelIncome,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "Valid Team",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        validTeam,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05,),
                                      const Text(
                                        "Total Assets",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        totalAssets,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
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
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFE27E1C),
                              Color(0xFF851161),
                            ])),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/team-icon-teamwork.png',
                            width: double.infinity,
                            color: Color(0xFF851161),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                              vertical: size.height * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Team Size",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        teamSize,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05,),
                                      const Text(
                                        "Level Income",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        levelIncome,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "Valid Team",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        validTeam,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05,),
                                      const Text(
                                        "Total Assets",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        totalAssets,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontFamily: 'MontserratLight',
                                          color: Color(0xFF00FFFF),
                                          fontSize: 20,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: myCustomerData.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFC6C8E9),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/refer.png',
                                    height: 34,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myCustomerData[index].name,
                                        style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'MontserratMedium',
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        myCustomerData[index].mobile,
                                        style: const TextStyle(
                                            color: Color(0xFF4F4F53),
                                            fontFamily: 'MontserratLight',
                                            fontSize: 12),
                                      ),
                                      // Text(
                                      //   myCustomerData[index].status == '0' ? 'Not Verified' : 'Verified',
                                      //   style: TextStyle(
                                      //       color: myCustomerData[index].status == '0' ? Colors.redAccent : Colors.green,
                                      //       fontFamily: 'MontserratLight',
                                      //       fontSize: 10),
                                      // ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                      "₹ ${myCustomerData[index].referLevelIncome}",
                                    style: const TextStyle(
                                        color: Color(0xFFDF5E00),
                                        fontFamily: 'MontserratMedium',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
