import 'dart:convert';

import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/user.dart';
import 'package:flutter/material.dart';

import 'Helper/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BankDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
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
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _holdernameController,
                decoration: InputDecoration(labelText: 'Holder Name'),

              ),
              SizedBox(height: 16),
              TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(labelText: 'Account Number'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _ifscCodeController,
                decoration: InputDecoration(labelText: 'IFSC Code'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _branchNameController,
                decoration: InputDecoration(labelText: 'Branch Name'), // New field for branch name
              ),
              SizedBox(height: 24),
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
                child: Text('Save Bank Details'),
              ),
            ],
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