import 'dart:convert';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/addupi.dart';
import 'package:color_challenge/my_withdrawal_records.dart';
import 'package:color_challenge/withdrawal_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  final TextEditingController _withdrawalAmtController =
      TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;
  String balance = "";
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        balance = prefs.getString(Constant.BALANCE)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.white,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "My Balance",
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.greyss,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                     Text(
                       "₹$balance",
                      style: TextStyle(
                          fontSize: 24,
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserra"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "UPI ID",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 4),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12.0)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _withdrawalAmtController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Enter UPI ID',
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Amount",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 4),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _withdrawalAmtController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: '₹ Please Input',
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: const TextSpan(
                            text: "Minimum : ",
                            style: TextStyle(
                                color: colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                            children: [
                              TextSpan(
                                text: "₹ 100",
                                style: TextStyle(
                                    color: colors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        double withdrawalAmt =
                            double.tryParse(_withdrawalAmtController.text) ??
                                0.0;
                        if (withdrawalAmt < 100) {
                          utils.showToast("please enter minimum 100");
                        } else {
                          doWithdrawal();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Verify.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Withdrawal',
                            style: TextStyle(
                                fontSize: 14,
                                color: colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Record",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              MyWithdrawals()

            ],
          ),
        ),
      ),
    );
  }

  void doWithdrawal()async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.WITHDRAWAL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.AMOUNT: _withdrawalAmtController.text,
      Constant.TYPE: Constant.DEBIT,

    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];
    utils.showToast(message);
  }
}
