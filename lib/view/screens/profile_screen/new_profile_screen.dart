import 'dart:convert';

import 'package:color_challenge/model/user.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/view/screens/login/mainScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/apiCall.dart';

class NewProfileScreen extends StatefulWidget {
  final String mobileNumber;

  const NewProfileScreen({Key? key, required this.mobileNumber})
      : super(key: key);

  @override
  _NewProfileScreenState createState() => _NewProfileScreenState(mobileNumber);
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  String gender = 'male';
  String deafDumb = '0';
  String language = 'tamil';
  late SharedPreferences prefs;

  // List of items in our dropdown menu
  var items = [
    'male',
    'female',
    'other',
  ];
  var itemsDeafDumb = [
    '0', // Corresponding to 'no'
    '1', // Corresponding to 'yes'
  ];
  // var itemsDeafDumb = [
  //   'no',
  //   'yes',
  // ];
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();

  _NewProfileScreenState(String mobileNumber) {
    _mobileNumber = mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Set width to the screen width
          height: MediaQuery.of(context)
              .size
              .height, // Set height to the screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.secondary_color
              ], // Change these colors to your desired gradient colors
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
                  SizedBox(height: size.height * 0.05),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _cityController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Enter City',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _ageController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    decoration:  InputDecoration(
                      labelText: 'Enter Age',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Select Gender",
                    style: TextStyle(fontSize: 12, color: colors.white),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double
                        .infinity, // Set the width to fill the available space
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white60,
                        width: 1.0, 
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,),
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
                      style: const TextStyle(color: colors.white),
                      dropdownColor:
                          colors.primary_color, // Change the text color
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Are you Deaf or Dumb?",
                    style: TextStyle(fontSize: 12, color: colors.white),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white60,
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,),
                    child: DropdownButton(
                      value: deafDumb,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: itemsDeafDumb.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item == '0'
                              ? 'No'
                              : 'Yes'), // Display 'No' or 'Yes' in the dropdown
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          deafDumb = newValue!;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _referCodeController,
                    decoration: InputDecoration(
                      labelText: 'Referral Code (optional)',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Select Customer Support",
                    style: TextStyle(fontSize: 12, color: colors.white),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white60,
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,),
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
                      style: const TextStyle(color: colors.white),
                      dropdownColor:
                          colors.primary_color,
                    ),
                  ),
                  const SizedBox(height: 24),
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
      Constant.EMAIL: _emailController.text.toString(),
      Constant.DEVICE_ID: prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.AGE: _ageController.text,
      Constant.SUPPORT_LAN: language,
      Constant.GENDER: gender,
      'deaf': int.parse(deafDumb),
      Constant.CITY: _cityController.text,
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    if (responseJson['success']) {
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
      // prefs.setString(Constant.DEAF, user.deaf);
      // prefs.setString(Constant.EMAIL, user.email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      Utils().showToast(responseJson['message']);
    }
  }
}
