import 'package:a1_ads/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class A1UploadedJob extends StatefulWidget {
  const A1UploadedJob({super.key});

  @override
  State<A1UploadedJob> createState() => _A1UploadedJobState();
}

class _A1UploadedJobState extends State<A1UploadedJob> {
  List<List<String>> listData = [
    [
      'assets/images/complain 1.png',
      'Review',
      ''
    ],
    [
      'assets/images/reject 1.png',
      'Rejected',
      ''
    ],
    [
      'assets/images/success 1.png',
      'Paid',
      '500'
    ]
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: const Text(
      //     'A1 Jobs',
      //     style: TextStyle(
      //       fontFamily: 'MontserratLight',
      //       color: Color(0xFF000000),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      //   leading: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset('assets/images/Group 18197.png',height: 10,),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        itemCount: listData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: size.height * 0.15,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF161C7E),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'I want Logo design',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFFFFFFFF),
                      fontSize: 22,
                    ),
                  ),
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Status : ',
                          ),
                          TextSpan(
                            text: listData[index][1],
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: listData[index][1] == 'Review' ? const Color(0xFFE39A56) : listData[index][1] == 'Rejected' ? const Color(0xFFEE3434) : const Color(0xFF45FF4D),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    listData[index][2] != '' ? RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF66BB6A),
                          fontSize: 20,
                        ),
                        children: [
                          const TextSpan(
                            text: '₹ ',
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          TextSpan(
                            text: listData[index][2],
                          ),
                        ],
                      ),
                    ) : const SizedBox(),
                    const SizedBox(width: 10,),
                    Image.asset(listData[index][0],height: size.height * 0.07,)
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
