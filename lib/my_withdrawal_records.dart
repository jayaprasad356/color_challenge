import 'dart:convert';
import 'package:color_challenge/withdrawal_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
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
   withdrawalsData.clear();
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      Constant.USER_ID:"1"// prefs.getString(Constant.ID)!,
    };

    String response = await apiCall(Constant.MY_WITHDRAWALS_LIST_URL,bodyObject);

    final jsonsData = jsonDecode(response);

    for (var Data in jsonsData['data']) {
      final id = Data['id'];
      final amount = Data["amount"];
      final type = Data['type'];
      final status = Data['status'];
      final datetime = Data['datetime'];

      WithdrawalData data = WithdrawalData(id, amount, type, status, datetime);
      withdrawalsData.add(data);
    }
    return withdrawalsData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getWithdrawalsData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (withdrawalsData.isEmpty) {
          return Center(
              child: Column(
                children: const [
                 // CircularProgressIndicator(color: colors.primary),
                ],
              ));
        } else {
          return  SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: withdrawalsData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: colors.cc_button_grey,
                      margin: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 5, top: 5),
                      child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            top: 10,
                                            bottom: 10.0),
                                        child: Text("Coins",
                                            style: TextStyle(
                                                color: colors.cc_greyText,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 10),
                                        child: Text("₹${withdrawalsData[index].amount}",
                                            style: const TextStyle(
                                                color: colors.black,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text("Time",
                                            style: TextStyle(
                                                color: colors.cc_greyText,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12)),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 10),
                                        child: Text(withdrawalsData[index].datetime,
                                            style: const TextStyle(
                                                color: colors.black,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 15.0,
                                            top: 10,
                                            bottom: 10),
                                        child: Text("State",
                                            style: TextStyle(
                                                color: colors.cc_greyText,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, bottom: 10),
                                        child: Text(
                                          withdrawalsData[index].status=="0"? "Pending":"Completed",
                                          style: const TextStyle(
                                              color: colors.cc_green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 4.0, bottom: 4),
                                  child: RichText(
                                    text: const TextSpan(
                                      text: "Fee : ",
                                      style: TextStyle(
                                          color: colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat"),
                                      children: [
                                        TextSpan(
                                          text: "₹ 30",
                                          style: TextStyle(
                                              color: colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                              "Montserconst rat"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Tamilarasan",
                                        style: TextStyle(
                                            color: colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12, bottom: 15),
                                      child: Text(
                                        "tamil@okaxis",
                                        style: TextStyle(
                                            color: colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ));
              },
            ),
          );
        }
      },
    );
  }
}
