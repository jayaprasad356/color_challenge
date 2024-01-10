import 'dart:convert';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/model/withdrawal_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWithdrawals extends StatefulWidget {
  const MyWithdrawals({Key? key}) : super(key: key);

  @override
  State<MyWithdrawals> createState() => _MyWithdrawalsState();
}

class _MyWithdrawalsState extends State<MyWithdrawals> {
  late List<WithdrawalData> withdrawalsData = [];
  late SharedPreferences prefs;
  Future<List<WithdrawalData>> _getWithdrawalsData() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)!,
    };

    String response =
        await apiCall(Constant.MY_WITHDRAWALS_LIST_URL, bodyObject);

    final jsonsData = jsonDecode(response);
    withdrawalsData.clear();

    for (var Data in jsonsData['data']) {
      final id = Data['id'];
      final amount = Data["amount"];
      final status = Data['status'];
      final datetime = Data['datetime'];

      WithdrawalData data = WithdrawalData(id, amount, status, datetime);
      withdrawalsData.add(data);
    }
    return withdrawalsData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("withdrawalsData: $withdrawalsData");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _getWithdrawalsData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // if (withdrawalsData.isNotEmpty) {
          if (withdrawalsData.isEmpty) {
          return const Center(
              child: Column(
            children: [
              // CircularProgressIndicator(color: colors.primary),
            ],
          ));
        } else {
          return SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: withdrawalsData.length,
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
                              'assets/images/transfer 1.png',
                              height: 34,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  withdrawalsData[index].status=="0"? "Pending": withdrawalsData[index].status=="1" ? "Completed" : "Cancelled",
                                  style: TextStyle(
                                      color: withdrawalsData[index].status=="0"? colors.primary : withdrawalsData[index].status=="1" ? const Color(0xFF31800C) : Colors.red,
                                      fontFamily: 'MontserratBold',
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  withdrawalsData[index].datetime,
                                  style: const TextStyle(
                                      color: Color(0xFF4F4F53),
                                      fontFamily: 'MontserratLight',
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Text(
                              withdrawalsData[index].amount,
                              style: const TextStyle(
                                  color: Color(0xFF31800C),
                                  fontFamily: 'MontserratBold',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
            // child: ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   itemCount: withdrawalsData.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return SingleChildScrollView(
            //       child: GestureDetector(
            //           onTap: () {},
            //           child: Card(
            //             color: colors.cc_velvet,
            //             margin: const EdgeInsets.only(
            //                 right: 15, left: 15, bottom: 5, top: 5),
            //             child: Padding(
            //                 padding: const EdgeInsets.all(0),
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Column(
            //                           children:  [
            //                             const Padding(
            //                               padding: EdgeInsets.only(
            //                                   left: 15,
            //                                   top: 10,
            //                                   bottom: 10.0),
            //                               child: Text("Amount",
            //                                   style: TextStyle(
            //                                       color: colors.white,
            //                                       fontFamily: 'Montserrat',
            //                                       fontSize: 12)),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 15, bottom: 10),
            //                               child: Text("₹${withdrawalsData[index].amount}",
            //                                   style: const TextStyle(
            //                                       color: colors.white,
            //                                       fontFamily: 'Montserrat',
            //                                       fontSize: 12,
            //                                       fontWeight:
            //                                       FontWeight.bold)),
            //                             ),
            //                           ],
            //                         ),
            //                         Column(
            //                           crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                           children:  [
            //                             const Padding(
            //                               padding: EdgeInsets.only(
            //                                   top: 10, bottom: 10),
            //                               child: Text("Time",
            //                                   style: TextStyle(
            //                                       color: colors.white,
            //                                       fontFamily: 'Montserrat',
            //                                       fontSize: 12)),
            //                             ),
            //                             Padding(
            //                               padding:
            //                               const EdgeInsets.only(bottom: 10),
            //                               child: Text(withdrawalsData[index].datetime,
            //                                   style: const TextStyle(
            //                                       color: colors.white,
            //                                       fontFamily: 'Montserrat',
            //                                       fontSize: 12,
            //                                       fontWeight:
            //                                       FontWeight.bold)),
            //                             ),
            //                           ],
            //                         ),
            //                         Column(
            //                           crossAxisAlignment:
            //                           CrossAxisAlignment.end,
            //                           children:  [
            //                             const Padding(
            //                               padding: EdgeInsets.only(
            //                                   right: 15.0,
            //                                   top: 10,
            //                                   bottom: 10),
            //                               child: Text("Status",
            //                                   style: TextStyle(
            //                                       color: colors.white,
            //                                       fontFamily: 'Montserrat',
            //                                       fontSize: 12)),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   right: 15, bottom: 10),
            //                               child: Text(
            //                                 withdrawalsData[index].status=="0"? "Pending": withdrawalsData[index].status=="1" ? "Completed" : "Cancelled",
            //                                 style:  TextStyle(
            //                                     color: withdrawalsData[index].status == "0"  ? colors.greyss : withdrawalsData[index].status=="1" ? colors.cc_green : colors.red ,
            //                                     fontWeight: FontWeight.bold,
            //                                     fontFamily: 'Montserrat',
            //                                     fontSize: 12),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                     const SizedBox(
            //                       height: 8,
            //                     ),
            //
            //                   ],
            //                 )),
            //           )),
            //     );
            //   },
            // ),
          );
        }
      },
    );
  }
}
