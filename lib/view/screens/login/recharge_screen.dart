import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Color.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen>{
  late SharedPreferences prefs;
  final PCC c = Get.find<PCC>();
  List<XFile> uploadStatusPhoto = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F8F8),
        title: const Text(
          "Payment",
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
          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/qr_image.png",height: size.height * 0.2,),
              const SizedBox(height: 20,),
              const Text(
                'Open',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'MontserratMedium',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Scan and pay for your purchase, then wait for up to 15 minutes for your wallet to recharge, or it may be completed within a day.',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'MontserratLight',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/youtube-logo-png.png", color: Colors.grey ,height: 50,width: 100,fit: BoxFit.fill,),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {},
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF161C7E),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Demo video',
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
              const SizedBox(height: 10,),
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
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    // prefs = await SharedPreferences.getInstance();
                    // String userId = prefs.getString(Constant.ID)!;
                    // debugPrint("userId: $userId");
                    // var image = c.getUploadStatusPhoto.value;
                    // debugPrint("photo: ${image}");
                    // homeController.uploadStatus(context, noOfView.text,
                    //     c.getUploadStatusPhoto.value as XFile);
                    // if (userId != null) {
                    //   await c.postMyPost(userId, c.photo.value as XFile);
                    // } else {
                    //   debugPrint('User ID not available.');
                    // }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF161C7E),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Upload',
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
            ],
          ),
        ),
      ),
    );
  }
}
