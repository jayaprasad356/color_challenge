import 'package:color_challenge/result.dart';
import 'package:flutter/material.dart';

import '../Helper/Color.dart';
import '../homePage.dart';
import '../wallet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selctedIndex = 0;
  String title = "HOME";
  bool _actionsVisible = true;
  bool _leftArrowVisible = true;
  final screens = [const HomePage(), Result(), wallet()];

  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      if (index == 2) {
        title = "wallet";
        _actionsVisible = false;
        _leftArrowVisible = false;
      } else if (index == 1) {
        title = "Result";
        _actionsVisible = true;
        _leftArrowVisible = false;
      } else {
        title = "HOME";
        _actionsVisible = true;
        _leftArrowVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.white,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Montserra', color: colors.black),
        ),
        leading: _leftArrowVisible
            ? Icon(
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
                  "200",
                  style: TextStyle(
                      color: colors.primary,
                      fontFamily: "Montserra",
                      fontSize: 16),
                )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/images/add.png",
                    height: 24,
                    width: 24,
                  ),
                ),
              ]
            : [],
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 1),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(1)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/images/home.png",
                    ),
                    color: colors.black,
                  ),
                  label: 'Home',
                  backgroundColor: colors.white,
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/result.png"),
                        color: colors.black),
                    label: 'Result',
                    backgroundColor: colors.white),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Wallet.png"),
                        color: colors.black),
                    label: 'Wallet',
                    backgroundColor: colors.white),
              ],
              currentIndex: _selctedIndex,
              selectedItemColor: colors.primary,
              selectedIconTheme: IconThemeData(color: colors.red),
              onTap: _onItemTapped,
            ),
          )),
      body: screens[_selctedIndex],
    );
  }
}
