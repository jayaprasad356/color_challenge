import 'dart:convert';

import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BankDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Bank Details',style: TextStyle(fontFamily: 'Montserra', color: colors.white),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.primary_color2], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: colors.white,
          ),
        ),
      ),
      body: BankDetailsForm(),
    );
  }
}

class BankDetailsForm extends StatefulWidget {
  @override
  _BankDetailsFormState createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends State<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _holdernameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();
  TextEditingController _branchNameController = TextEditingController(); // New field for branch name
  late SharedPreferences prefs;
  String holder_name = "";
  String bank = "";
  String account_num = "";
  String ifsc="";
  String branch = "";
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {

        holder_name = prefs.getString(Constant.HOLDER_NAME)!;
        bank = prefs.getString(Constant.BANK)!;
        account_num = prefs.getString(Constant.ACCOUNT_NUM)!;
        ifsc = prefs.getString(Constant.IFSC)!;
        branch = prefs.getString(Constant.BRANCH)!;
        _holdernameController.text = holder_name;
        _accountNumberController.text = account_num;
        _bankNameController.text = bank;
        _ifscCodeController.text = ifsc;
        _branchNameController.text = branch;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width, // Set width to the screen width
        height: MediaQuery.of(context).size.height, // Set height to the screen height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
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
                TextField(
                  controller: _holdernameController,
                  decoration: const InputDecoration(labelText: 'Holder Name', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _accountNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Account Number', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ifscCodeController,
                  decoration: const InputDecoration(labelText: 'IFSC Code', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _bankNameController,
                  decoration: const InputDecoration(labelText: 'Bank Name', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _branchNameController,
                  decoration: const InputDecoration(labelText: 'Branch Name', labelStyle: TextStyle(color: Colors.white),hintStyle: TextStyle(color: Colors.white),),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      prefs = await SharedPreferences.getInstance();

                      String holderName = _holdernameController.text;
                      String bankName = _bankNameController.text;
                      String accountNumber = _accountNumberController.text;
                      String ifscCode = _ifscCodeController.text;
                      String branchName = _branchNameController.text;

                      var url = Constant.UPDATE_BANK_DETAILS;
                      Map<String, dynamic> bodyObject = {
                        Constant.USER_ID: prefs.getString(Constant.ID),
                        Constant.HOLDER_NAME: holderName,
                        Constant.BANK: bankName,
                        Constant.ACCOUNT_NUM: accountNumber,
                        Constant.BRANCH: branchName,
                        Constant.IFSC: ifscCode,
                      };
                      String jsonString = await apiCall(url, bodyObject);
                      final jsonResponse = jsonDecode(jsonString);
                      final message = jsonResponse['message'];
                      final status = jsonResponse['success'];
                      if (status) {
                        userDeatils();
                      }


                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  },
                  child: const Text('Save Bank Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void userDeatils() async {

    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.ACCOUNT_NUM, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);

    prefs.setString(Constant.HOLDER_NAME, user.holder_name);
    prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
    prefs.setString(Constant.IFSC, user.ifsc);
    prefs.setString(Constant.BANK, user.bank);
    prefs.setString(Constant.BRANCH, user.branch);
    setState(() {

      holder_name = prefs.getString(Constant.HOLDER_NAME)!;
      bank = prefs.getString(Constant.BANK)!;
      account_num = prefs.getString(Constant.ACCOUNT_NUM)!;
      ifsc = prefs.getString(Constant.IFSC)!;
      branch = prefs.getString(Constant.BRANCH)!;
      _holdernameController.text = holder_name;
      _accountNumberController.text = account_num;
      _bankNameController.text = bank;
      _ifscCodeController.text = ifsc;
      _branchNameController.text = branch;
    });
  }

}
