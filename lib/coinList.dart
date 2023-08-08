import 'dart:convert';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/challenge_data.dart';
import 'package:color_challenge/coin_data.dart';
import 'package:color_challenge/result_data.dart';
import 'package:color_challenge/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CoinList extends StatefulWidget {


  const CoinList({Key? key}) : super(key: key);

  @override
  State<CoinList> createState() => _CoinListState();
}


class _CoinListState extends State<CoinList> {
  late List<CoinData> datas = [];
  late SharedPreferences prefs;
  TextEditingController _coinController = TextEditingController();

  late String _fcmToken,contact_us;

  Future<List<CoinData>> _getUser() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.COIN_LIST_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);
    datas.clear();

    for (var u in jsonData['data']) {
      final id = u['id'];
      final coins = u["coins"];
      final price = u['price'];

      CoinData data = CoinData(id, coins, price);
      datas.add(data);
    }
    return datas;
  }
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              children: const [
                CircularProgressIndicator(color: colors.primary),
              ],
            ),
          );
        }else{
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  datas.length,
                      (index) => Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(0),
                          margin: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12.0),
                              Center(
                                child: Image.asset(
                                  "assets/images/multidoller.png",
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Center(
                                child: Text(
                                  datas[index].coins + ' Coins',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Center(
                                child: Text(
                                  'Rs.' + datas[index].price,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                color: colors.primary,
                                child: GestureDetector(
                                  onTap: () async {
                                    // Define the text to be sent to WhatsApp
                                    String text =
                                        'Hello, I want to purchase ' +
                                            datas[index].coins +
                                            ' coins and I will pay ' +
                                            datas[index].price +
                                            ' rupees.';

                                    // Encode the text for the URL
                                    String encodedText = Uri.encodeFull(text);
                                    final Uri launchUri = Uri(
                                      path: 'https://wa.me/+919442071531?text=$encodedText',
                                    );
                                    String uri =
                                        'https://wa.me/$contact_us?text=$encodedText';
                                    launchUrl(
                                      Uri.parse(uri),
                                      mode: LaunchMode.externalApplication,
                                    );

                                    // Check if the WhatsApp app is installed on the device
                                    // if (await canLaunchUrl(launchUri)) {
                                    //
                                    //   await launchUrl(launchUri);
                                    // } else {
                                    //   // Display an error message if the WhatsApp app is not installed
                                    //   showDialog(
                                    //     context: context,
                                    //     builder: (_) => AlertDialog(
                                    //       title: Text('Error'),
                                    //       content: Text('WhatsApp is not installed on your device.'),
                                    //       actions: [
                                    //         TextButton(
                                    //           child: Text('OK'),
                                    //           onPressed: () => Navigator.pop(context),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   );
                                    // }
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        'Get it Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

        }


      },
    );
  }


  showChallangeBottomSheet(int index) {
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
                height: 250,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child:  Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Join ${datas[index].id}", style: TextStyle(
                              color: colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat")),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _coinController,

                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Enter Amount'),
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
                          colorChallenge(datas,index);
                          Navigator.of(context).pop();
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
                              'Confirm',
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
  colorChallenge(List<CoinData> datas, int index)async{
    prefs = await SharedPreferences.getInstance();
    var url = Constant.COLOR_CHALLENGE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.COLOR_ID:datas[index].id.toString(),
      Constant.COINS: _coinController.text
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];

    Utils().showToast(message);
  }
  void userDeatils()async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.FCM_ID:_fcmToken
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
  }

}
