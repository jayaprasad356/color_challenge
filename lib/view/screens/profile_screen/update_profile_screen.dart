import 'dart:convert';

import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/view/screens/login/mainScreen.dart';
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

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: ProfileForm(),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String deafDumb = '0';
  String gender = 'male';
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
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String name = "";
  String city = "";
  String age = "";
  String email = "";
  String gender_save = "";
  String language_save = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        name = prefs.getString(Constant.NAME)!;
        city = prefs.getString(Constant.CITY)!;
        age = prefs.getString(Constant.AGE)!;
        gender = prefs.getString(Constant.GENDER)!;
        deafDumb = prefs.getString(Constant.DEAF)!;
        language = prefs.getString(Constant.SUPPORT_LAN)!;
        email = prefs.getString(Constant.EMAIL)!;

        _nameController.text = name;
        _cityController.text = city;
        _ageController.text = age;
        _emailController.text = email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:
            MediaQuery.of(context).size.width, // Set width to the screen width
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                    decoration: InputDecoration(
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
                  // const SizedBox(height: 1),
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
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
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
                      dropdownColor: colors.primary_color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Select Customer Support",
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
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
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
                      dropdownColor: colors.primary_color,
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
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
                    child: DropdownButton(
                      value: deafDumb,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: itemsDeafDumb.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item == '0' ? 'No' : 'Yes'),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          deafDumb = newValue!;
                        });
                      },
                      style: const TextStyle(color: colors.white),
                      dropdownColor: colors.primary_color,
                    ),
                  ),
                  const SizedBox(height: 24),
                  MaterialButton(
                    onPressed: () {
                      updateProfile();
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
                          'Update',
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

  Future<void> updateProfile() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.UPDATE_PROFILE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.NAME: _nameController.text,
      Constant.AGE: _ageController.text,
      Constant.SUPPORT_LAN: language,
      Constant.GENDER: gender,
      Constant.CITY: _cityController.text,
      Constant.DEAF: deafDumb,
      Constant.EMAIL: _emailController.text,
    };

    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    if (responseJson['success']) {
      Utils().showToast(responseJson['message']);
      final dataList = responseJson['data'] as List;
      final Users user = Users.fromJsonNew(dataList.first);

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
      prefs.setString(Constant.DEAF, user.deaf);
      prefs.setString(Constant.EMAIL, user.email);
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
