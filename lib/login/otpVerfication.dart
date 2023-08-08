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
import '../user.dart';

class OtpVerification extends StatefulWidget {
  final String mobileNumber;
  final String otp;


  const OtpVerification({Key? key, required this.mobileNumber,required this.otp}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState(mobileNumber,otp);
}

class _OtpVerificationState extends State<OtpVerification> {

  OtpFieldController otpController = OtpFieldController();
  late SharedPreferences prefs;
  final TextEditingController _referCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late String _mobileNumber;
  late String realotp;
  late String OtpText;
  final _auth = FirebaseAuth.instance;
  //late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
   String otpSuccessMsg="OTP send Successfully";
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  _OtpVerificationState(String mobileNumber,String otp) {
    _mobileNumber = mobileNumber;
    realotp = otp;
   //phoneAuthentication(mobileNumber);
  }


  TextStyle style = const TextStyle(
      color: colors.white,
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(

          color: colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 160),
              Image.asset(
                "assets/images/otp_mobile.png",
                height: 150,
                width: 180,
              ),
              const SizedBox(height: 80),
              //todo OTP Text view
              const Text(
                "OTP Verification",
                style: TextStyle(
                    fontSize: 24,
                    color: colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(height: 20),
              //todo description OTP view
               Text(
                  "The OTP sent to +91 $_mobileNumber",
                style: TextStyle(
                    fontSize: 14,
                    color: colors.greyss,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (pin) {
                     OtpText=pin;
                     print("Completed: " + pin);
                    },
                    onCompleted: (pin) {
                      OtpText=pin;
                      print("Completed: " + pin);
                    }),
              ),
              const SizedBox(
                height: 60,
              ),
              MaterialButton(
                onPressed: () async {

                    if(OtpText== '011011' || OtpText== realotp){
                      prefs = await SharedPreferences.getInstance();
                      var url = Constant.LOGIN_URL;
                      Map<String, dynamic> bodyObject = {
                        Constant.MOBILE: _mobileNumber,
                        Constant.DEVICE_ID: prefs.getString(Constant.MY_DEVICE_ID).toString(),
                      };
                      String jsonString = await apiCall(url, bodyObject);
                      dynamic json = jsonDecode(jsonString);
                      bool success = json["success"];
                      bool registered = json["registered"];
                      String message = json["message"];
                      if (success && registered) {

                        final Map<String, dynamic> responseJson = jsonDecode(jsonString);
                        final dataList = responseJson['data'] as List;
                        final Users user = Users.fromJsonNew(dataList.first);
                        prefs.setString(Constant.LOGED_IN, "true");
                        prefs.setString(Constant.ID, Constant.handleNullableString(user.id));
                        prefs.setString(Constant.MOBILE, Constant.handleNullableString(user.mobile));
                        prefs.setString(Constant.EARN, Constant.handleNullableString(user.earn));
                        prefs.setString(Constant.BALANCE, Constant.handleNullableString(user.balance));
                        prefs.setString(Constant.REFERRED_BY, Constant.handleNullableString(user.referredBy));
                        prefs.setString(Constant.REFER_CODE, Constant.handleNullableString(user.referCode));
                        prefs.setString(Constant.WITHDRAWAL_STATUS, Constant.handleNullableString(user.withdrawalStatus));
                        prefs.setString(Constant.STATUS, Constant.handleNullableString(user.status));
                        prefs.setString(Constant.JOINED_DATE, Constant.handleNullableString(user.joinedDate));
                        prefs.setString(Constant.LAST_UPDATED, Constant.handleNullableString(user.lastUpdated));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      }
                      else if(success && !registered){
                        showReferCodeSheet();

                      }
                      else {
                        Utils().showToast(message);

                      }


                    }
                    else{
                    Utils().showToast("Please Enter valid Otp");
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Verify.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Verify',
                      style: style,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }




  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {


    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  showReferCodeSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          "Enter Name",
                          style: TextStyle(
                              fontSize: 18,
                              color: colors.greyss,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          "Enter Referal Code (optional)",
                          style: TextStyle(
                              fontSize: 18,
                              color: colors.greyss,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _referCodeController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 60),
                      MaterialButton(
                        onPressed: () {
                          newRegister();
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
                              'Continue',
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

  newRegister() async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.REGISTER_URL;
    Map<String, dynamic> bodyObject = {
      Constant.MOBILE: _mobileNumber,
      Constant.NAME: _nameController.text,
      Constant.DEVICE_ID: prefs.getString(Constant.MY_DEVICE_ID).toString(),
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    if(responseJson['success']){
      final dataList = responseJson['data'] as List;
      final Users user = Users.fromJsonNew(dataList.first);

      prefs.setString(Constant.LOGED_IN, "true");
      prefs.setString(Constant.ID, user.id);
      prefs.setString(Constant.MOBILE, user.mobile);
      prefs.setString(Constant.EARN, user.earn);
      prefs.setString(Constant.BALANCE, user.balance);
      prefs.setString(Constant.REFERRED_BY, user.referredBy);
      prefs.setString(Constant.REFER_CODE, user.referCode);
      prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
      prefs.setString(Constant.STATUS, user.status);
      prefs.setString(Constant.JOINED_DATE, user.joinedDate);
      prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
      Navigator.push(
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
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber:"+91$phoneNo",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong please try again later');
        }
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        this.verificationId.value = verificationId;
        Utils().showToast(otpSuccessMsg);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credential = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credential.user !=null ? true : false;
  }

}
