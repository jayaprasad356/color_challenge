import 'dart:convert';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/homePage.dart';
import 'package:color_challenge/login/mainScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/apiCall.dart';
import '../new_profile_screen.dart';
import '../user.dart';

class NewProfileScreen_ extends StatefulWidget {
  final String mobileNumber;




  const NewProfileScreen_({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _NewProfileScreenState createState() => _NewProfileScreenState(mobileNumber);
}

class _NewProfileScreenState extends State<NewProfileScreen_> {
  String gender = 'male';
  String language = 'tamil';
  late SharedPreferences prefs;


  // List of items in our dropdown menu
  var items = [
    'male',
    'female',
    'other',
  ];
  var languages = [
    'tamil',
    'kannada',
    'telugu',
    'hindi',
    'english',
  ];
  late String _mobileNumber;
  late String realotp;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();

  _NewProfileScreenState(String mobileNumber) {
    _mobileNumber = mobileNumber;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, // Set width to the screen width
          height: MediaQuery.of(context).size.height, // Set height to the screen height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Enter Name', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                    style: TextStyle(color: Colors.white),

                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _cityController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Enter City', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),

                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _ageController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    decoration: InputDecoration(labelText: 'Enter Age', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Select Gender",
                    style: TextStyle(
                        fontSize: 12,
                        color: colors.white),
                  ),
                  Container(
                    width: double.infinity, // Set the width to fill the available space
                    child: DropdownButton(
                      value: gender,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      style: TextStyle(color: colors.white),
                      dropdownColor: colors.primary_color,// Change the text color
                      underline: Container(
                        height: 2,
                        color: colors.cc_telegram, // Change the line color here
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _referCodeController,
                    decoration: InputDecoration(labelText: 'Referral Code (optional)', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Select Customer Support",
                    style: TextStyle(
                        fontSize: 12,
                        color: colors.white),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity, // Set the width to fill the available space
                    child: DropdownButton(
                      value: language,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: languages.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          language = newValue!;
                        });
                      },
                      style: TextStyle(color: colors.white),
                      dropdownColor: colors.primary_color,// Change the text color
                      underline: Container(
                        height: 2,
                        color: colors.cc_telegram, // Change the line color here
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  MaterialButton(
                    onPressed: () {
                      newRegister();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/btnbg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: colors.white,
                              fontSize: 18,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  newRegister() async {

    prefs = await SharedPreferences.getInstance();

    var url = Constant.REGISTER_URL;
    Map<String, dynamic> bodyObject = {
      Constant.MOBILE: _mobileNumber,
      Constant.NAME: _nameController.text.toString(),
      Constant.DEVICE_ID: prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.AGE: _ageController.text,
      Constant.SUPPORT_LAN:language,
      Constant.GENDER:gender,
      Constant.CITY:_cityController.text,
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    if(responseJson['success']){

      final dataList = responseJson['data'] as List;
      final Users user = Users.fromJsonNew(dataList.first);

      //Utils().showToast("hi");
      prefs.setString(Constant.LOGED_IN, "true");
      prefs.setString(Constant.ID, user.id);
      prefs.setString(Constant.MOBILE, user.mobile);
      prefs.setString(Constant.EARN, user.earn);
      prefs.setString(Constant.CITY, user.city);
      prefs.setString(Constant.AGE, user.age);
      prefs.setString(Constant.GENDER, user.gender);
      prefs.setString(Constant.SUPPORT_LAN, user.support_lan);
      prefs.setString(Constant.BALANCE, user.balance);
      prefs.setString(Constant.REFERRED_BY, user.referredBy);
      prefs.setString(Constant.REFER_CODE, user.referCode);
      prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
      prefs.setString(Constant.STATUS, user.status);
      prefs.setString(Constant.JOINED_DATE, user.joinedDate);
      prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );

    }
    else{
      Utils().showToast(responseJson['message']);
    }

  }


}
