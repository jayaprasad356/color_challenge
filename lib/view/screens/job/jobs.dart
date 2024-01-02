import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/job/a1_all_job.dart';
import 'package:a1_ads/view/screens/job/a1_uploaaded_job.dart';
import 'package:a1_ads/view/screens/job/job_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

List<Map<String, dynamic>> webLinkList = [
  {
    'name': 'Web Developer',
    'company_name': 'Reqroots',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': '₹15,000 a month',
    'job_type': ['Full-time'],
    'job_timing': ['Monday to Friday'],
    'description':
        'Designing and building responsive and mobile-friendly websites optimised for different devices and browsers',
  },
  {
    'name': 'Web Developer Intern',
    'company_name': 'Frontline trades',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': '₹3,000.00 - ₹33,371.49 per month',
    'job_type': ['Full-time', 'Internship'],
    'job_timing': ['Monday to Friday'],
    'description':
        'As a web development intern, you will actively participate in designing, developing, and maintaining websites and web applications.',
  },
  {
    'name': 'Web developer - Full stack',
    'company_name': 'STUVELS SOFTWARE SOLUTIONS',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': '₹25,640 - ₹1,03,288 a month',
    'job_type': ['Full-time'],
    'job_timing': [],
    'description':
        'Qualification BE, MCA, M. Sc. IT (good academic background BE > 70%, 10th, +2 > 80%)',
  },
  {
    'name': 'Jr. Web Designer',
    'company_name': 'App Innovation Technologies',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': '₹10,957.72 - ₹19,296.69 a month',
    'job_type': ['Full-time'],
    'job_timing': ['Day shift'],
    'description':
        '   designing and implementing applications\n   developing and testing software',
  },
  {
    'name': 'Trainee Full Stack Developer',
    'company_name': 'CAP Digisoft Solutions',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': '₹19,296.69 a month',
    'job_type': ['Full-time'],
    'job_timing': [],
    'description':
        'Basic understanding of web development technologies, including HTML, CSS, JavaScript, React.js, Python, Flutter and PHP.',
  },
  {
    'name': 'Front End Developer',
    'company_name': 'Ad Media Cbe',
    'location': 'Coimbatore, Tamil Nadu',
    'salary': 'From ₹15,228 a month',
    'job_type': ['Permanent', 'Full-time'],
    'job_timing': ['Fixed shift'],
    'description':
        'A Front-End Web Developer is a tech industry professional who builds the front portion of websites that customers, guests, or clients use on a daily basis.',
  },
];

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final JobCon jobCon = Get.find<JobCon>();
  late SharedPreferences prefs;
  String gender = "";

  final selectedColor = Colors.white;
  final tabs = [
    const Tab(text: 'All jobs'),
    const Tab(text: 'Uploaded jobs'),
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      gender = prefs.getString(Constant.GENDER)!;
    });
    tabController = TabController(length: tabs.length, vsync: this);
    print("tabController ${tabController.index}");
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleTabSelection(int index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF2F2F2),
        title: TabBar(
          controller: tabController,
          indicator: const BoxDecoration(
            boxShadow: null,
            border: Border(
              bottom: BorderSide(
                width: 4,
                color: Color(0xFF161C7E),
                style: BorderStyle.solid,
              ),
            ),
          ),
          labelColor: colors.black,
          unselectedLabelColor: const Color(0xFF242426),
          labelStyle: const TextStyle(
            fontFamily: 'MontserratLight',
            fontSize: 20,
          ),
          tabs: tabs,
          onTap: (index) => handleTabSelection(index),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: size.height * 0.21,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF161C7E),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10000),
                            child: Image.asset(
                              gender == 'male'
                                  ? 'assets/images/Group 18201.png'
                                  : 'assets/images/Group 18200.png',
                              height: size.height * 0.05,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'swetha',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: const Color(0xFFDF5E00),
                            ),
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
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/icon/Group (1).png",
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Hi , I want logo design for beauty parlour can you create for me , i will pay for you',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'MontserratLight',
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'upto income',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFEBE10),
                                  fontSize: 12,
                                ),
                              ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Get.to(const A1AllJob());
                          },
                          child: Container(
                            height: 30,
                            width: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: const Color(0xFF2E7D32),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Apply',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          const A1UploadedJob(),
          // ListView.builder(
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         height: size.height * 0.21,
          //         width: double.infinity,
          //         margin:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(16),
          //           color: const Color(0xFF161C7E),
          //         ),
          //         child: Column(
          //           children: [
          //             Row(
          //               children: [
          //                 ClipRRect(
          //                   borderRadius: BorderRadius.circular(10000),
          //                   child: Image.asset(
          //                     gender == 'male'
          //                         ? 'assets/images/Group 18201.png'
          //                         : 'assets/images/Group 18200.png',
          //                     height: size.height * 0.05,
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   width: 10,
          //                 ),
          //                 const Text(
          //                   'swetha',
          //                   textAlign: TextAlign.start,
          //                   style: TextStyle(
          //                     fontFamily: 'MontserratLight',
          //                     color: Color(0xFFFFFFFF),
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 const Text(
          //                   'I want Logo design',
          //                   textAlign: TextAlign.start,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: TextStyle(
          //                     fontFamily: 'MontserratLight',
          //                     color: Color(0xFFFFFFFF),
          //                     fontSize: 22,
          //                   ),
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.end,
          //                   children: [
          //                     RichText(
          //                       textAlign: TextAlign.end,
          //                       text: const TextSpan(
          //                         style: TextStyle(
          //                           fontFamily: 'MontserratLight',
          //                           color: Color(0xFFFFFFFF),
          //                           fontSize: 20,
          //                         ),
          //                         children: [
          //                           TextSpan(
          //                             text: '₹ ',
          //                             style: TextStyle(
          //                               fontFamily: 'MontserratBold',
          //                             ),
          //                           ),
          //                           TextSpan(
          //                             text: '500',
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     const Text(
          //                       'Income',
          //                       textAlign: TextAlign.end,
          //                       style: TextStyle(
          //                         fontFamily: 'MontserratLight',
          //                         color: Color(0xFFFEBE10),
          //                         fontSize: 12,
          //                       ),
          //                     ),
          //                   ],
          //                 )
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(const A1UploadedJob());
          //                 },
          //                 child: Container(
          //                   height: 30,
          //                   width: 90,
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(1000),
          //                     color: const Color(0xFF2E7D32),
          //                   ),
          //                   child: const Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       SizedBox(
          //                         width: 10,
          //                       ),
          //                       Text(
          //                         'Status ',
          //                         textAlign: TextAlign.start,
          //                         style: TextStyle(
          //                           fontFamily: 'MontserratLight',
          //                           color: Color(0xFFFFFFFF),
          //                           fontSize: 12,
          //                         ),
          //                       ),
          //                       SizedBox(
          //                         width: 10,
          //                       ),
          //                       RotatedBox(
          //                           quarterTurns: 2,
          //                           child: Icon(
          //                             Icons.arrow_back,
          //                             color: Colors.white,
          //                             size: 15,
          //                           ))
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}
