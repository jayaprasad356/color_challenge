import 'dart:convert';

import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/view/screens/profile_screen/update_profile_screen.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:a1_ads/view/screens/upi_screen/apply%20leave.dart';
import 'package:a1_ads/view/screens/upi_screen/my_withdrawal_records.dart';
import 'package:a1_ads/view/screens/upi_screen/verify_ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'bank_detail_screen.dart';

class WhatsappStatus extends StatefulWidget {
  const WhatsappStatus({Key? key}) : super(key: key);

  @override
  State<WhatsappStatus> createState() => _WhatsappStatusState();
}

class _WhatsappStatusState extends State<WhatsappStatus> {
  final TextEditingController _withdrawalAmtController =
      TextEditingController();
  TextEditingController noOfView = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();
  Utils utils = Utils();
  late SharedPreferences prefs;
  final PCC c = Get.find<PCC>();
  List<XFile> uploadStatusPhoto = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.whatsappListData();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDisabled = true;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        title: const Text(
          "Upload WhatsApp Status",
          style: TextStyle(
            fontFamily: 'MontserratLight',
            color: Color(0xFF000000),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            'assets/images/Group 18197.png',
            height: 34,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose file',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () {
                          // c.pickImageFromGallery();
                          c.getUploadWhatsappStatusPhoto().then((value) {
                            picture:
                            uploadStatusPhoto;
                          });
                          print("photos : ${c.getUploadStatusPhoto}");
                        },
                        child: PhotoDisplayWidget(photo: c.getUploadStatusPhoto.value),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Number of View',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: noOfView,
                decoration: InputDecoration(
                  hintText: 'Enter Number of View',
                  labelStyle: const TextStyle(color: Color(0xFF000000),fontFamily: 'MontserratBold',),
                  hintStyle: const TextStyle(color: Color(0xFF878787),fontFamily: 'MontserratLight'),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFD00000),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFD00000),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(color: Color(0xFF727272),fontFamily: 'MontserratBold',),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    prefs = await SharedPreferences.getInstance();
                    String userId = prefs.getString(Constant.ID)!;
                    debugPrint("userId: $userId");
                    var image = c.getUploadStatusPhoto.value;
                    debugPrint("photo: ${image}");
                    homeController.uploadStatus(context, noOfView.text,
                        c.getUploadStatusPhoto.value as XFile);
                    // if (userId != null) {
                    //   await c.postMyPost(userId, c.photo.value as XFile);
                    // } else {
                    //   debugPrint('User ID not available.');
                    // }
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF161C7E),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Upload file',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.91,
                child: Obx(
                    () => ListView.builder(
                    itemCount: homeController.whatsappListJson.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFC6C8E9),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                            () => Image.network(
                                homeController.whatsappListJson[index].image,
                                height: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                                  () => Text(
                                homeController.whatsappListJson[index].status == '0' ? 'Not Approval' : 'Approval',
                                style: TextStyle(
                                    color: homeController.whatsappListJson[index].status == '0' ? Colors.redAccent : Colors.green,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 14),
                              ),
                            ),
                            Expanded(child: Container()),
                            Obx(
                                  () => Text(
                                homeController.whatsappListJson[index].datetime,
                                style: const TextStyle(
                                    color: Color(0xFFDF5E00),
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
