import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/controller/upi_controller.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/util/index_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyAD extends StatefulWidget {
  const VerifyAD({super.key});

  @override
  State<VerifyAD> createState() => _VerifyADState();
}

class _VerifyADState extends State<VerifyAD> {
  String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
  String ads_link = '';
  bool _isLoading = true;
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.primary_color2,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.primary_color2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Verify AD",
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Set width to the screen width
          height: MediaQuery.of(context)
              .size
              .height, // Set height to the screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: MaterialButton(
              //     onPressed: () async {
              //       watchAds();
              //     },
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Container(
              //       height: 40,
              //       width: 140,
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage("assets/images/btnbg.png"),
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'Next',
              //           style: TextStyle(
              //               color: colors.white,
              //               fontSize: 14,
              //               fontFamily: "Montserrat",
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              Image.network(
                ads_image,
                fit: BoxFit.contain,
                height: 300, // Set the desired height
                width: 300, // Set the desired width
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    _isLoading = false;
                    return child;
                  } else if (_isLoading) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  } else {
                    return child;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      watchAds();
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.check,size: 40,color: Colors.green,),
                        Text(
                          'Available',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      watchAds();
                    },
                    child: Column(
                      children: [
                        Transform.rotate(
                          angle: 45 * (3.1415926535 / 180),
                          child: const Icon(
                            Icons.add,
                            // Adjust other properties as needed
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        const Text(
                          'Not Available',
                          style: TextStyle(
                              color: colors.red,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> watchAds() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.ADS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    if (jsonData['success']) {
      // Utils().showToast(jsonData['message']);
      final dataList = jsonData['data'] as List;
      final datass = dataList.first;
      prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
      prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);
      setState(() {
        ads_image = prefs.getString(Constant.ADS_IMAGE)!;
        ads_link = prefs.getString(Constant.ADS_LINK)!;
      });
    } else {
      Utils().showToast(jsonData['message']);
    }
  }
}
