import 'dart:convert';
import 'package:a1_ads/model/transactionl_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late List<TransactionData> transactionData = [];
  late SharedPreferences prefs;
  Future<List<TransactionData>> _getWithdrawalsData() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)!,
    };

    String response = await apiCall(Constant.TRANSACTIONS_LIST_URL,bodyObject);

    final jsonsData = jsonDecode(response);
    transactionData.clear();

    for (var Data in jsonsData['data']) {
      final id = Data['id'];
      final amount = Data["amount"];
      final type = Data['type'];
      final datetime = Data['datetime'];

      TransactionData data = TransactionData(id, amount, type, datetime);
      transactionData.add(data);
    }
    return transactionData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        title: const Text(
          "Transaction",
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
      body: FutureBuilder(
        future: _getWithdrawalsData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (transactionData.isEmpty) {
            return const Center(
                child: Column(
                  children: [
                   // CircularProgressIndicator(color: colors.primary),
                  ],
                ));
          } else {
            // return Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: 5,
            //     shrinkWrap: true,
            //     itemBuilder: (BuildContext context, int index) {
            //       return SingleChildScrollView(
            //         child: GestureDetector(
            //             onTap: () {},
            //             child: Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: const Color(0xFFC6C8E9),
            //               ),
            //               margin: const EdgeInsets.symmetric(vertical: 5),
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 10, horizontal: 20),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   Image.asset(
            //                     'assets/images/transfer 1.png',
            //                     height: 34,
            //                   ),
            //                   const SizedBox(
            //                     width: 10,
            //                   ),
            //                   const Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         "Ad_bonus",
            //                         style: TextStyle(
            //                             color: Color(0xFF000000),
            //                             fontFamily: 'MontserratLight',
            //                             fontSize: 16),
            //                       ),
            //                       SizedBox(
            //                         height: 5,
            //                       ),
            //                       Text(
            //                         "2023 - 12 - 26  04 : 55",
            //                         style: TextStyle(
            //                             color: Color(0xFF4F4F53),
            //                             fontFamily: 'MontserratLight',
            //                             fontSize: 10),
            //                       ),
            //                     ],
            //                   ),
            //                   Expanded(child: Container()),
            //                   const Text(
            //                     '₹50',
            //                     style: TextStyle(
            //                         color: Color(0xFFDF5E00),
            //                         fontFamily: 'MontserratLight',
            //                         fontSize: 16),
            //                   ),
            //                 ],
            //               ),
            //             )),
            //       );
            //     },
            //   ),
            // );
            return  SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: transactionData.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          color: colors.cc_velvet,
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
                                            child: Text("Amount",
                                                style: TextStyle(
                                                    color: colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            child: Text("₹${transactionData[index].amount}",
                                                style: const TextStyle(
                                                    color: colors.white,
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
                                                    color: colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 10),
                                            child: Text(transactionData[index].datetime,
                                                style: const TextStyle(
                                                    color: colors.white,
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
                                            child: Text("Type",
                                                style: TextStyle(
                                                    color: colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15, bottom: 10),
                                            child: Text(
                                              transactionData[index].type,
                                              style: const TextStyle(
                                                  color: colors.white,
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

                                ],
                              )),
                        )),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
