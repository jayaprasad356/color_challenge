import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/model/slider_data.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/util/index_path.dart';
import 'package:color_challenge/view/screens/shorts_vid/player.dart';
import 'package:color_challenge/view/screens/shorts_vid/post_upload.dart';
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

class MyOffer extends StatefulWidget {
  const MyOffer({Key? key}) : super(key: key);

  @override
  State<MyOffer> createState() => _MyOfferState();
}

class _MyOfferState extends State<MyOffer> {
  late SharedPreferences prefs;
  String offer_image = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      //userDeatils();
      //String? userId = prefs.getString(Constant.ID);
      offer_image = prefs.getString(Constant.OFFER_IMAGE)!;
      //ads_status("status");
    });
    //prefs = await SharedPreferences.getInstance();

    //debugPrint("userId_offer : $userId");
    //c.offerAPI(userId!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  offer_image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
              ),
        ),
      ),
    );
  }
}
