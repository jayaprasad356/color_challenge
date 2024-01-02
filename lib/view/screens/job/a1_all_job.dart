import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class A1AllJob extends StatefulWidget {
  const A1AllJob({super.key});

  @override
  State<A1AllJob> createState() => _A1AllJobState();
}

class _A1AllJobState extends State<A1AllJob> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();

  List<XFile> photo = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'A1 Jobs',
          style: TextStyle(
            fontFamily: 'MontserratLight',
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/Group 18197.png',
              height: 10,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFDF5E00),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '25 Applied',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/icon/Group (1).png",
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'I want Logo design',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              const Text(
                'Hi , I want logo design for beauty parlour can you create for me , i will pay for you',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF000000),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: size.height * 0.1,),
              RichText(
                textAlign: TextAlign.end,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: 'Name :',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextSpan(
                      text: ' Shweta Studio',
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              RichText(
                textAlign: TextAlign.end,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: 'Deadline :',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextSpan(
                      text: ' 01-01-2024',
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF161C7E),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/profits 1.png",
                        height: size.height * 0.12,
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Upto Income',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFFFFCB00),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.end,
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'MontserratLight',
                                color: Color(0xFF00FF38),
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: '₹ ',
                                  style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                  ),
                                ),
                                TextSpan(
                                  text: '500',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              const Text(
                'Choose file',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF000000),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10,),
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
              SizedBox(height: size.height * 0.1,),
              Align(
                alignment: Alignment.center,
                child: InkWell(
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
              SizedBox(height: size.height * 0.05,),
            ],
          ),
        ),
      ),
    );
  }
}
