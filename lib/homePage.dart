import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/adScreen.dart';
import 'package:color_challenge/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'login/mainScreen.dart';
import 'online_jobs.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);



  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late SharedPreferences prefs;
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String today_ads_remain = "0";
  String level = '0',status = '';
  String history_days = '0';
  String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
  String ads_link = '';
  int time_start = 0;
  double seconds = 0.0;
  String time_left = '0';
  String max_coin = "0";
  String refer_amount = "0";
  String generate_coin = "0";
  bool _isLoading = true;
  String balance = "0";
  bool timerStarted = false;
  bool isTrial = true,isPremium = false;
  Random random = Random();
  late String contact_us;
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "",basic_wallet = "",premium_wallet = "",target_refers = "",today_ads = "0",total_ads = "0";
  double progressbar = 0.0;


  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      userDeatils();
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      adsApi();
      //ads_status("status");
    });




  }
  void userDeatils() async {

    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.MOBILE, user.mobile);
    prefs.setString(Constant.NAME, user.name);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    prefs.setString(Constant.MIN_WITHDRAWAL, user.min_withdrawal);
    prefs.setString(Constant.HOLDER_NAME, user.holder_name);
    prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
    prefs.setString(Constant.IFSC, user.ifsc);
    prefs.setString(Constant.BANK, user.bank);
    prefs.setString(Constant.BRANCH, user.branch);
    prefs.setString(Constant.BASIC_WALLET, user.basic_wallet);
    prefs.setString(Constant.PREMIUM_WALLET, user.premium_wallet);
    prefs.setString(Constant.TARGET_REFERS, user.target_refers);
    setState(() {
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      target_refers = prefs.getString(Constant.TARGET_REFERS)!;
      today_ads = prefs.getString(Constant.TODAY_ADS)!;
      total_ads = prefs.getString(Constant.TOTAL_ADS)!;
    });

  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {

      if (starttime >= 60) {
        timer.cancel();

        setState(() {
          progressbar = 0.0;
          timerStarted = false;

        });

      } else {
        setState(() {
          starttime++;
          seconds = starttime % 60;
          progressbar = starttime / 60;

        });
      }
    });
  }
  String separateNumber(String number) {
    if (number.length != 12) {
      throw Exception("Number must be 12 digits long.");
    }

    List<String> groups = [];

    for (int i = 0; i < 12; i += 4) {
      groups.add(number.substring(i, i + 4));
    }

    return groups.join('-');
  }


  bool isMultipleOf5(int number) {
    return number % 5 == 0;
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
                colors: [colors.primary_color, colors.secondary_color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Card(
                          color: Color(0xFF060A70),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.widget_color, // Set the border color
                                  width: 2, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(8), // Set border radius
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Basic Wallet",
                                          style: GoogleFonts.poppins( // Use GoogleFonts.poppins() to access Poppins font
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OnlineJobs(),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/info.png',
                                            height: 30,
                                            width: 20,
                                          ),
                                        )

                                      ],
                                    ),

                                    Text(
                                      "No Refers",
                                      style: GoogleFonts.poppins( // Use GoogleFonts.poppins() to access Poppins font
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    ),
                                    SizedBox(height: 5,),
                                    Card(
                                      color: Color(0xFF060A70),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colors.widget_color2, // Set the border color
                                            width: 2, // Set the border width
                                          ),
                                          borderRadius: BorderRadius.circular(35),
                                          color: Color(0xFF080A42),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 3.0, left: 20.0, right: 20.0, bottom: 3.0),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/money.png',
                                                height: 30,
                                                width: 20,
                                              ),
                                              SizedBox(width: 5), // Adding some spacing between image and text
                                              Text(
                                                "₹ $basic_wallet",
                                                style: TextStyle(fontSize: 18, color: Colors.white),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                       addTomainbalance('basic_wallet');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/main_balance_btn.png',
                                            height: 50,
                                            width: 120,// Replace with the actual image path
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        Card(
                          color: Color(0xFF060A70),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.widget_color, // Set the border color
                                  width: 2, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(8), // Set border radius
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Premium Wallet",
                                          style: GoogleFonts.poppins( // Use GoogleFonts.poppins() to access Poppins font
                                            fontSize: 14,
                                            color: colors.widget_color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OnlineJobs(),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/info.png',
                                            height: 30,
                                            width: 20,
                                          ),
                                        )
                                      ],
                                    ),

                                    Text(
                                      "$target_refers Refers",
                                      style: GoogleFonts.poppins( // Use GoogleFonts.poppins() to access Poppins font
                                        fontSize: 12,
                                        color: colors.widget_color,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    ),
                                    SizedBox(height: 5,),
                                    Card(
                                      color: Color(0xFF060A70),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colors.widget_color2, // Set the border color
                                            width: 2, // Set the border width
                                          ),
                                          borderRadius: BorderRadius.circular(35),
                                          color: Color(0xFF080A42),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 3.0, left: 20.0, right: 20.0, bottom: 3.0),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/money.png',
                                                height: 30,
                                                width: 20,
                                              ),
                                              SizedBox(width: 5), // Adding some spacing between image and text
                                              Text(
                                                "₹ $premium_wallet",
                                                style: TextStyle(fontSize: 18, color: Colors.white),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        addTomainbalance('premium_wallet');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/main_balance_btn.png',
                                            height: 50,
                                            width: 120,// Replace with the actual image path
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Image.network(
                      ads_image,
                      fit: BoxFit.contain,
                      height: 300, // Set the desired height
                      width: 300,  // Set the desired width
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          _isLoading = false;


                          return child;
                        } else if (_isLoading) {
                          return CircularProgressIndicator(); // Show loading indicator
                        } else {
                          return child;
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {

                        launchUrl(
                          Uri.parse(ads_link),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(
                        "click here to purchase",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),

                    ),
                    SizedBox(height: 20),
                    Text(
                      timerStarted ? "$seconds seconds" :"",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),


                    SizedBox(height: 5),
                    MaterialButton(
                      onPressed: () async {
                        if(!timerStarted){

                          watchad();

                        }else{
                          Utils().showToast("Please wait...");
                        }


                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/btnbg.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Watch Ad',
                            style: TextStyle(
                                color: colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: progressbar,
                      minHeight: 10, // Set the desired height of the progress bar
                      backgroundColor: Colors.grey[300], // Background color of the progress bar
                      valueColor: AlwaysStoppedAnimation<Color>(colors.widget_color), // Color of the progress indicator
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Today Viewed Ads: $today_ads',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total Viewed Ads: $total_ads',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Register bonus ₹500 credit after achieving monthly target',
                        style: TextStyle(
                            color: colors.widget_color,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),

    );

  }
  showSheet() {
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
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          serilarandom,
                          style: TextStyle(
                            letterSpacing: 5.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: colors.black,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _serialController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                            hintText: 'Enter PIN',
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if(serilarandom != _serialController.text.toString()){
                            Utils().showToast("Pin Wrong");
                          }else{
                            _serialController.text = '';
                            Navigator.pop(context);

                            //ads_status("watch_ad");

                          }

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
                              'Verify',
                              style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Today Viewed Ads: 26',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),                      const SizedBox(height: 5),
                      Text(
                        'Today Viewed Ads: 26',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          );
        });


  }


  String generateSerialNumber() {
    final random = Random();
    final maxDigits = 4;
    String randomNumber = '';

    for (int i = 0; i < maxDigits; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }
  void  showLevelAlert(BuildContext context, String level) {
    String levelcontent = "";
    String leveltitle = "";
    if(level == 'Free Trial'){
      levelcontent = 'Total 200 Ads \n0.125 paise per Ad\n7 Days duration';
      leveltitle = 'Free Trial';

    }else{
      levelcontent = 'Total 12,000 Ads \n0.25 paise per Ad\n30 Days duration';
      leveltitle = 'Plan (₹1500 only)';

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(leveltitle),
          content: Text(levelcontent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(level == 'Free Trial'){
                  Navigator.of(context).pop();

                }else{
                  String text = 'Hello, I want to purchase Plan';
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );

                }

              },
              child: Text(level == 'Free Trial' ? 'Close' : 'Purchase Plan'),
            ),
          ],
        );
      },
    );
  }
  void  showPremiumLevelAlert(BuildContext context, String level) {
    String levelcontent = "";
    String leveltitle = "";
    if(level == '1'){
      levelcontent = 'Watch 400 Ads per day\n1Ad = 1 Ad\nEarn ₹100 in 3 hrs 20 mins';
      leveltitle = 'Level 1';

    }else if(level == '2'){
      levelcontent = 'Watch 200 Ads per day\n1Ad = 2 Ads\nEarn ₹100 in 1 hrs 40 mins';
      leveltitle = 'Level 2(3 refers)';

    }else{
      levelcontent = 'Watch 100 Ads per day\n1Ad = 4 Ads\nEarn ₹100 in 50 mins\nNext Month Free plan';
      leveltitle = 'Level 3(5 refers)';

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(leveltitle),
          content: Text(levelcontent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(level == 'Free Trial'){
                  Navigator.of(context).pop();

                }else{
                  String text = 'Hello, I need help to reach next level';
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );

                }

              },
              child: Text(level == '1' ? 'Close' : 'Get Help'),
            ),
          ],
        );
      },
    );
  }
  // Method to get device info.
  Future<void> ads_status(String type) async {

    var url = Constant.TRIAL_ADS_LIST;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.DEVICE_ID:prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.TYPE: type
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if(jsonResponse['success'] && type == 'status'){
      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        history_days = jsonResponse['history_days'].toString();

        status = jsonResponse['status'].toString();
        level = jsonResponse['level'].toString();
        starttime = double.parse(time_left);
        if(status == '1'){
          isTrial = false;
          isPremium = true;
        }
        if(time_start == 1){
          //startTimer();
        }

      });

    }else if(jsonResponse['success'] && type == 'watch_ad'){

      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        level = jsonResponse['level'].toString();
        status = jsonResponse['status'].toString();
        history_days = jsonResponse['history_days'].toString();
        ads_image = jsonResponse['ads_image'].toString();
        starttime = double.parse(time_left);

        if(status == '1'){
          isTrial = false;
          isPremium = true;
        }
        if(time_start == 1){
          //startTimer();
        }
      });

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
    }


  }

  Future<void> addTomainbalance(String wallet_type) async {
    var url = Constant.ADD_MAIN_BALANCE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.WALLET_TYPE:wallet_type,
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if(jsonResponse['success']){
      Utils().showToast(jsonResponse['message']);

    }else{
      Utils().showToast(jsonResponse['message']);

    }
    userDeatils();

  }

  Future<void> watchad() async {
    var url = Constant.VIEW_AD_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);

    if(jsonResponse['success']){
      Utils().showToast(jsonResponse['message']);
      starttime = 0;
      timerStarted = true;
      adsApi();
      startTimer();
      userDeatils();


    }else{
      Utils().showToast(jsonResponse['message']);

    }

  }

  Future<void> adsApi() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.ADS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;

    prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
    prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);

    setState(() {
      ads_image =  prefs.getString(Constant.ADS_IMAGE)!;
      ads_link =  prefs.getString(Constant.ADS_LINK)!;
    });
  }


}
