import 'package:color_challenge/result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/Constant.dart';
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
  bool _leftArrowVisible = true;
  late User user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance="";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        coins = prefs.getString(Constant.COINS)!;
        balance=prefs.getString(Constant.BALANCE)!;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      if (index == 2) {
        title = "wallet";
        _actionsVisible = false;
        _leftArrowVisible = false;
      } else if (index == 1) {
        title = "Result";
        _actionsVisible = false;
        _leftArrowVisible = false;
      } else {
        title = "HOME";
        _actionsVisible = true;
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
                      showTopupBottomSheet();
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
              : [],
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
                        style: TextStyle(
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

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
        break;
      case 1:
        return Result();
        break;
      default:
        return wallet();
        break;
    }
  }
}
