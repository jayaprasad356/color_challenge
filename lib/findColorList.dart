import 'dart:convert';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/challenge_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'findcolor_data.dart';
import 'login/mainScreen.dart';

class FindColorList extends StatefulWidget {
  const FindColorList({Key? key}) : super(key: key);

  @override
  State<FindColorList> createState() => _FindColorListState();
}

class _FindColorListState extends State<FindColorList> {
  late List<FindcolorData> datas = [];
  late SharedPreferences prefs;
  Color customColor2 = Color(int.parse("0xFFCFD8DC"));
  Color resultColor = Colors.transparent; // Initialize with a default color

  Color tappedCardColor = Colors.transparent; // Separate variable to track tapped card color

  // Initialize the Future once
  late Future<List<FindcolorData>> _futureData;
  String coins = "0";


  @override
  void initState() {
    super.initState();
    _futureData = _getUser();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        coins = prefs.getString(Constant.COINS)!;
      });
    });
  }

  Future<List<FindcolorData>> _getUser() async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.FINDCOLORS_LIST_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonsData = jsonDecode(jsonString);
    if (jsonsData['result'] != null) {
      setState(() {
        resultColor = Color(int.parse("0xFF" + jsonsData['result']));
      });
    }
    datas = [];

    for (var u in jsonsData['data']) {
      final color_code = u['color_code'];
      FindcolorData data = FindcolorData(color_code);
      datas.add(data);
    }
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureData, // Use the initialized future here
      builder: (BuildContext context, AsyncSnapshot<List<FindcolorData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: const [
                // CircularProgressIndicator(color: colors.primary),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          // Choose the index of the color you want to display
          int colorIndex = 0;

          return Column(
            children: [
              // Design your color widget here
              Container(
                height: 100,
                color: resultColor, // Set the desired color here
                child: Center(
                  child: Text(
                    "", // Add your text or design here
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 8, // Add some spacing between the color design and the grid
              ),
              Text(
                'Find Above Color and Earn 100 Coins with spend 5 coins to open each box',
                style: TextStyle(
                    fontSize: 14,
                    color: colors.cc_pink,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
              ),
              SizedBox(
                height: 5, // Add some spacing between the color design and the grid
              ),
              Text(
                'Balance $coins Coins',
                style: TextStyle(
                    fontSize: 14,
                    color: colors.black,
                    fontWeight: FontWeight.w200,
                    fontFamily: "Montserrat"),
              ),
              SizedBox(
                height: 5, // Add some spacing between the color design and the grid
              ),
              Expanded(
                // Use Expanded to make sure the grid takes the remaining space
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // Number of columns you want
                    crossAxisSpacing: 8, // Horizontal space between columns
                    mainAxisSpacing: 8, // Vertical space between rows
                  ),
                  itemCount: snapshot.data!.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    Color customColor = Color(int.parse("0xFF" + snapshot.data![index].color_code));
                    Color customColor2 = Color(int.parse("0xFFCFD8DC"));

                    return GestureDetector(
                      onTap: () {
                        showLoadingDialog(context);
                        spendCoins(customColor);

                      },
                      child: Card(
                        color: tappedCardColor == customColor ? customColor : customColor2,
                        margin: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> spendCoins(Color customColor) async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.SPEND_COINS_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.COINS: '5',
      'appupdate': '1'
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonData = jsonDecode(jsonString);
    //
    if (jsonData["success"]) {
      setState(() {
        coins = jsonData["coins"];
        prefs.setString(Constant.COINS, coins);
      });
      Navigator.of(context).pop();
      setState(() {
        tappedCardColor = customColor; // Update only the tappedCardColor
      });
      if(tappedCardColor == resultColor){
        showGreenSnackBar(context,"Correct,You Won 100 Coins");
        creditCoins();
      }else{
        showRedSnackBar(context,"Wrong");
      }
      
    }else{
      Utils().showToast(jsonData["message"]);
      Navigator.of(context).pop();

    }

  }
  void showRedSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red, // Set the background color to red
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 1),

      ),
    );
  }
  void showGreenSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green, // Set the background color to red
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Won 100 Coins'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // Replace this with your custom loading widget if desired
        );
      },
    );
  }


  Future<void> creditCoins() async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.CREDIT_COINS_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.COINS: '100'
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonData = jsonDecode(jsonString);
    //Utils().showToast(jsonData["message"]);
    if (jsonData["success"]) {
      Utils().showToast(jsonData["message"]);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );


    }
  }
}
