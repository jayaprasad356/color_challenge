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
  TextEditingController _upiIdController = TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;
  String balance = "";
  String minimum = "";
  late String _upiId;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        balance = prefs.getString(Constant.BALANCE)!;
        minimum = prefs.getString(Constant.MIN_WITHDRAWAL)!;
        _upiIdController.text = prefs.getString(Constant.UPI)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDisabled = true;
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
                      style: const TextStyle(
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
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 4),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            child: IgnorePointer(
                              ignoring: _isDisabled,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _upiIdController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: IconButton(
                              icon: Icon(
                                _isDisabled ? Icons.edit : Icons.check,
                                color: colors.primary,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      buildUpdateUpiDialog(context,
                                          (String upiId) {
                                    // update the UPI ID here using the upiId parameter
                                    // ...
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
                          text: TextSpan(
                            text: "Minimum : ",
                            style: const TextStyle(
                                color: colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                            children: [
                              TextSpan(
                                text: "₹$minimum",
                                style: const TextStyle(
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
              const MyWithdrawals()
            ],
          ),
        ),
      ),
    );
  }

  void doWithdrawal() async {
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

  void updateUpi(String upi) async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.UPDATE_UPI_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.UPI: upi
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonData = jsonDecode(jsonString);
    Utils().showToast(jsonData["message"]);
    final dataList = jsonData['data'] as List;
    if (jsonData["success"]) {
      final datass = dataList.first;
      setState(() {
        String upi_id = datass[Constant.UPI];
        prefs.setString(Constant.UPI, datass[Constant.UPI]);
        _upiIdController.text = upi_id;
      });
    }
  }

  Widget buildUpdateUpiDialog(
      BuildContext context, void Function(String) upiIdCallback) {
    final TextEditingController _enterupiController = TextEditingController();

    return AlertDialog(
      title: const Center(
        child: Text(
          'Enter UPI ID',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _enterupiController,
              decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                hintText: 'testupibankid@okaxis,com',
              ),
              style: const TextStyle(
                backgroundColor: Colors.transparent,
              ),
              enabled:
                  true, // set to false if you want the text field to be disabled
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              String upi = _enterupiController.text;
              updateUpi(upi);

              Navigator.pop(context);
            },
            child: const Text(
              'Update UPI',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: colors.primary, // set button background color here
            ),
          ),
        ],
      ),
    );
  }
}
