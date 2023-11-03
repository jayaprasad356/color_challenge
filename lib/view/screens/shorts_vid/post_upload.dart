import 'dart:io';

import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/util/index_path.dart';
import 'package:a1_ads/view/screens/job/online_jobs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostUpload extends StatefulWidget {
  const PostUpload({super.key});

  @override
  State<PostUpload> createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {
  final PCC c = Get.find<PCC>();
  late SharedPreferences prefs;
  List<XFile> photo = [];
  String basic_wallet = "";
  String media_wallet = "",
      post_left = "";

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      userDeatils();
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      media_wallet = prefs.getString(Constant.MEDIA_WALLET)!;
      post_left = prefs.getString(Constant.POST_LEFT)!;
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

    prefs.setString(Constant.BASIC_WALLET, user.basic_wallet);
    setState(() {
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
        title: const Text(
          "Upload Post",
          style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
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
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Card(
                    color: const Color(0xFF060A70),
                    child: Container(
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Media Wallet",
                              style: GoogleFonts.poppins(
                                // Use GoogleFonts.poppins() to access Poppins font
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${post_left} Posts",
                              style: GoogleFonts.poppins(
                                // Use GoogleFonts.poppins() to access Poppins font
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              color: const Color(0xFF060A70),
                              child: Container(
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors
                                        .widget_color2, // Set the border color
                                    width: 2, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                  color: const Color(0xFF080A42),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/money.png',
                                        height: 30,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Adding some spacing between image and text
                                      Text(
                                        "₹ $media_wallet",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                addTomainbalance('media_wallet');
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/main_balance_btn.png',
                                    height: 50,
                                    width:
                                        120, // Replace with the actual image path
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
                    color: const Color(0xFF060A70),
                    child: Container(
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 5.0, right: 5.0, bottom: 3.0,),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Purchase Post\n₹20",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'MontserratBold', color: colors.white),
                            ),
                            const Text(
                              "10 likes = ₹1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'MontserratBold', color: colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: () async{
                                prefs = await SharedPreferences.getInstance();
                                String? userId = prefs.getString(Constant.ID);
                                debugPrint("userId : $userId");
                                c.purchaseAPI(userId!);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 30,
                                width: size.width * 0.255,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/btnbg.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Center(
                                  child: Text(
                                    'Purchase now',
                                    style: TextStyle(
                                        color: colors.white,
                                        fontSize: 10,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select Post Photo",
                style: TextStyle(
                    fontFamily: 'MontserratBold', color: colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        // c.pickImageFromGallery();
                        c.gallery().then((value) {
                          picture:
                          photo;
                        });
                        print("photos : ${c.photo}");
                      },
                      child: PhotoDisplayWidget(photo: c.photo.value),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Caption",
                style: TextStyle(
                    fontFamily: 'MontserratBold', color: colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                style: TextStyle(
                    fontFamily: 'MontserratBold', color: colors.black),
                decoration: InputDecoration(
                  hintText: "Enter your Caption.",
                  hintStyle: TextStyle(
                      fontFamily: 'MontserratBold', color: colors.black12),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async {
                    String? userId = await c.getUserId();
                    debugPrint("userId : $userId");
                    if (userId != null) {
                      await c.postMyPost(userId, c.photo.value as XFile);
                    } else {
                      debugPrint('User ID not available.');
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 40,
                    width: size.width * 0.6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/btnbg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTomainbalance(String walletType) async {
    var url = Constant.ADD_MAIN_BALANCE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.WALLET_TYPE: walletType,
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if (jsonResponse['success']) {
      Utils().showToast(jsonResponse['message']);
    } else {
      Utils().showToast(jsonResponse['message']);
    }
    userDeatils();
  }
}

class PhotoDisplayWidget extends StatelessWidget {
  final XFile? photo;

  const PhotoDisplayWidget({Key? key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: photo != null
          ? Image.file(File(photo!.path))
          : Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(16)),
              alignment: Alignment.center,
              child: const Text(
                'Select Post Photo',
                style: TextStyle(
                    color: colors.white,
                    fontSize: 14,
                    fontFamily: "MontserratBold",
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
