import 'dart:convert';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/challenge_data.dart';
import 'package:color_challenge/result_data.dart';
import 'package:color_challenge/user.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_data.dart';

class ColorList extends StatefulWidget {
  final void Function(String coins) updateAmount;

  const ColorList({Key? key, required this.updateAmount}) : super(key: key);

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  late List<ColorData> datas = [];
  late SharedPreferences prefs;
  TextEditingController _coinController = TextEditingController();


  Future<List<ColorData>> _getUser() async {
    datas.clear();
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.COLOR_LIST_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    for (var u in jsonData['data']) {
      final id = u['id'];
      final name = u["name"];
      final code = u['code'];

      ColorData data = ColorData(id, name, code);
      datas.add(data);
    }
    return datas;
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
            height: 250,width: double.infinity,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                datas.length,
                    (index) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(int.parse(
                              datas[index].code.replaceAll('#', '0xFF'))),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                         // showChallangeBottomSheet(index);
                          showChallangeBottomSheet(index);
                        },

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              "assets/images/fly.png",
                              height: 24,
                              width: 24,
                            ),
                             const SizedBox(height: 6),
                             Padding(
                               padding: const EdgeInsets.only(right: 12,left: 12),
                               child: Text(
                                'Join',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                             ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        datas[index].name,
                        style: const TextStyle(fontSize: 12,fontFamily: "Montserrat",fontWeight: FontWeight.bold),
                      ),
                    ],
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
                          child: Text("Join ${datas[index].name}", style: TextStyle(
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
  colorChallenge(List<ColorData> datas, int index)async{
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
    userDeatils();
    Utils().showToast(message);
  }
  void userDeatils()async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);
    widget.updateAmount(user.coins);

    prefs.setBool(Constant.BET_STATUS, true);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.COINS, user.coins);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.CHALLENGE_STATUS, user.challengeStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
  }

}
