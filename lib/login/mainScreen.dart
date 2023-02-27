import 'dart:convert';

import 'package:color_challenge/result.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/apiCall.dart';
import '../Helper/utils.dart';
import '../homePage.dart';
import '../upiPay.dart';
import '../user.dart';
import '../wallet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _payAmountController = TextEditingController();
  int _selctedIndex = 0;
  String title = "HOME";
  bool _actionsVisible = true;
  bool _logoutVisible = false;
  bool _leftArrowVisible = false;
  late User user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance = "";
  String text = 'Click here Send ScreenShoot';
  String link = 'http://t.me/Colorchallengeapp1';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        setupSettings();
        coins = prefs.getString(Constant.COINS)!;
        balance = prefs.getString(Constant.BALANCE)!;
      });
    });
  }

  void updateAmount(String coinss) {
    setState(() {
      coins = coinss;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      if (index == 2) {
        title = "wallet";
        _actionsVisible = false;
        _logoutVisible = true;
        _leftArrowVisible = false;
      } else if (index == 1) {
        title = "Result";
        _actionsVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
      } else {
        title = "HOME";
        _actionsVisible = true;
        _logoutVisible = false;
        _leftArrowVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            title,
            style:
                const TextStyle(fontFamily: 'Montserra', color: colors.black),
          ),
          leading: _leftArrowVisible
              ? const Icon(
                  Icons.arrow_back_outlined,
                  color: colors.black,
                )
              : (null),
          actions: _actionsVisible
              ? [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/images/coin.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                  Center(
                      child: Text(
                    coins,
                    style: const TextStyle(
                        color: colors.primary,
                        fontFamily: "Montserra",
                        fontSize: 16),
                  )),
                  GestureDetector(
                    onTap: () {
                      showUpiDeatilSheet();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/images/add.png",
                        height: 24,
                        width: 24,
                      ),
                    ),
                  )
                ]
              : [
                  _logoutVisible
                      ? GestureDetector(
                          onTap: () {
                            prefs.setString(Constant.LOGED_IN, "false");
                            SystemNavigator.pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/images/logout.png",
                              height: 24,
                              width: 30,
                            ),
                          ),
                        )
                      : const Text("")
                ],
        ),
        bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                        "assets/images/home.png",
                      ),
                      color: _selctedIndex == 0 ? colors.primary : colors.black,
                    ),
                    label: 'Home',
                    backgroundColor: colors.white,
                  ),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          const AssetImage("assets/images/result.png"),
                          color: _selctedIndex == 1
                              ? colors.primary
                              : colors.black),
                      label: 'Result',
                      backgroundColor: colors.white),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          const AssetImage("assets/images/Wallet.png"),
                          color: _selctedIndex == 2
                              ? colors.primary
                              : colors.black),
                      label: 'Wallet',
                      backgroundColor: colors.white),
                ],
                currentIndex: _selctedIndex,
                selectedItemColor: colors.primary,
                onTap: _onItemTapped,
              ),
            )),
        body: getPage(_selctedIndex));
  }

  showTopupBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Top up",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                          child: Text(
                        "Current Balance",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        balance,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: colors.primary),
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Enter Coins"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _payAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: '5 - 1000'),
                            style: const TextStyle(
                                backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          String amt;
                          amt = _payAmountController.text;
                          double doubleValue = double.parse(amt);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayPage(doubleValue)),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 80,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Verify.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  showUpiDeatilSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Add Payment",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            Utils().showToast("Copied !");
                            Clipboard.setData(const ClipboardData(
                                text: "BHARATPE09912930379@yesbankltd"));
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: colors.red),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "BHARATPE09912930379@yesbankltd",
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Image.asset(
                                  "assets/images/copy.png",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                          child: Text(
                        "Send amount to this UPI Id ",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              launch(link);
                            },
                            child: Text(link),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: IconButton(
                              icon: Icon(Icons.copy),
                              onPressed: () {
                               ontop();
                              },
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const Center(
                          child: Text(
                        "After completing your payment send screen shot ",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      const Center(
                          child: Text(
                        " to above telegram chat and claim your coins",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            launch(link);
                          },
                          color: colors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Chat Support',
                                  style: TextStyle(
                                    color: colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(updateAmount: updateAmount);
        break;
      case 1:
        return const Result();
        break;
      default:
        return const wallet();
        break;
    }
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;

    prefs.setString(
        Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
    prefs.setString(
        Constant.CHALLENGE_STATUS, datass[Constant.CHALLENGE_STATUS]);
    prefs.setString(Constant.REGISTER_POINTS, datass[Constant.REGISTER_POINTS]);
    prefs.setString(Constant.MIN_WITHDRAWAL, datass[Constant.MIN_WITHDRAWAL]);
    prefs.setString(Constant.MIN_DP_COINS, datass[Constant.MIN_DP_COINS]);
    prefs.setString(Constant.MAX_DP_COINS, datass[Constant.MAX_DP_COINS]);
  }

  ontop() {
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
    Utils().showToast("Copied!");
  }
}
