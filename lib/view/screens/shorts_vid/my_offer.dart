import 'package:a1_ads/controller/main_screen_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/util/index_path.dart';
import 'package:a1_ads/view/screens/shorts_vid/player.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOffer extends StatefulWidget {
  const MyOffer({Key? key}) : super(key: key);

  @override
  State<MyOffer> createState() => _MyOfferState();
}

class _MyOfferState extends State<MyOffer> {
  late SharedPreferences prefs;
  // String offer_image = '';
  final PCC c = Get.find<PCC>();
  final MainController mainController = Get.find<MainController>();
  List<String> DeviceID = [];
  String deviceID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    initializeData();
  }

  void initializeData() async {
    // SharedPreferences.getInstance().then((value) {
    //   prefs = value;
    //   //userDeatils();
    //   //String? userId = prefs.getString(Constant.ID);
    //   offer_image = prefs.getString(Constant.OFFER_IMAGE)!;
    //   //ads_status("status");
    // });
    prefs = await SharedPreferences.getInstance();
    deviceID = prefs.getString(Constant.MY_DEVICE_ID)!;
    debugPrint("MyOffer deviceID: $deviceID");
    c.offerAPI(prefs.getString(Constant.ID)!);
    setState(() {});
    // DeviceID.add(deviceID);
    // prefs.setStringList("DeviceIDList", DeviceID);
    // areLastTwoIdsEqual();
    // bool lastTwoIdsEqual = areLastTwoIdsEqual();
    // Get.snackbar("Equal", lastTwoIdsEqual == true ? 'Last Device ID is Equal' : 'Last Device ID is Not Equal',colorText: Colors.blue,backgroundColor: Colors.white);
  }

  bool areLastTwoIdsEqual() {
    late bool isTrue;

    // Retrieve the last two elements of the list
    String lastId = DeviceID[DeviceID.length - 1];
    String secondLastId = DeviceID[DeviceID.length - 2];

    if (lastId == secondLastId) {
      isTrue = true;
      debugPrint("Equal");
    } else {
      isTrue = false;
      debugPrint("Not Equal");
    }

    // Compare the last two elements
    return isTrue;
  }

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of device IDs
    List<String>? storedDeviceIDs = prefs.getStringList("DeviceIDList");
    debugPrint("storedDeviceIDs: $storedDeviceIDs");

    if (storedDeviceIDs != null) {
      setState(() {
        DeviceID = storedDeviceIDs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                    () => c.offerImageURS.isNotEmpty
                    ? Container(
                  width: size.width,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      c.offerImageURS.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
                    : const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                String? uri = prefs.getString(Constant.WHATSPP_GROUP_LINK);
                debugPrint("uri: $uri");
                launchUrl(
                  Uri.parse(uri!),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Container(
                width: size.width * 0.6,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFF00D95F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/whatsapp-icon-2048x2048-64wjztht 1.png",
                      height: 30,
                    ),
                    const Text(
                      'Whatsapp Group Link',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // body: Container(
      //     width:
      //     MediaQuery.of(context).size.width, // Set width to the screen width
      //     height: MediaQuery.of(context)
      //         .size
      //         .height, // Set height to the screen height
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [colors.primary_color, colors.secondary_color],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ),
      //     ),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: [
      //         const SizedBox(
      //           height: 10,
      //         ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //               child: Obx(
      //                 () => c.offerImageURS.isNotEmpty
      //                     ? Container(
      //                         width: size.width,
      //                         height: size.height * 0.7,
      //                         decoration: BoxDecoration(
      //                             color: Colors.transparent,
      //                             borderRadius: BorderRadius.circular(16)),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(16),
      //                           child: Image.network(
      //                             c.offerImageURS.toString(),
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //                       )
      //                     : const Center(
      //                         child: SizedBox(
      //                           height: 50.0,
      //                           width: 50.0,
      //                           child: CircularProgressIndicator(
      //                             value: null,
      //                             strokeWidth: 7.0,
      //                           ),
      //                         ),
      //                       ),
      //               ),
      //             ),
      //             const SizedBox(height: 20,),
      //             InkWell(
      //               onTap: () {
      //                 String? uri = prefs.getString(Constant.WHATSPP_GROUP_LINK);
      //                 debugPrint("uri: $uri");
      //                 launchUrl(
      //                   Uri.parse(uri!),
      //                   mode: LaunchMode.externalApplication,
      //                 );
      //               },
      //               child: Container(
      //                 width: size.width * 0.6,
      //                 height: 40,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(5),
      //                   color: const Color(0xFF00D95F),
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Image.asset(
      //                       "assets/images/whatsapp-icon-2048x2048-64wjztht 1.png",
      //                       height: 30,
      //                     ),
      //                     const Text(
      //                       'Whatsapp Group Link',
      //                       style: TextStyle(
      //                         fontFamily: 'MontserratBold',
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //   ),
      // ),
    );
  }
}
