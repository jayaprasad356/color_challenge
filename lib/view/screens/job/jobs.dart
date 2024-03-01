import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/job/a1_all_job.dart';
import 'package:a1_ads/view/screens/job/a1_uploaaded_job.dart';
import 'package:a1_ads/view/screens/job/job_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
    const Tab(text: 'Joined jobs'),
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
    jobCon.allJobs();
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
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
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
          labelColor: const Color(0xFF161C7E),
          unselectedLabelColor: const Color(0xFF242426),
          labelStyle: const TextStyle(
            fontFamily: 'MontserratLight',
            fontSize: 20,
          ),
          tabs: tabs,
          onTap: (index) {
            setState(() {
              handleTabSelection(index);
              if (index == 0) {
                jobCon.allJobs();
              } else if (index == 1) {
                jobCon.usersJoinedJobs();
              }
            });
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Obx(
            () => ListView.builder(
                itemCount: jobCon.allJobsJson.length,
                itemBuilder: (context, index) {
                  var percentageBar =
                      double.parse(jobCon.allJobsJson[index].slotsLeft) /
                          double.parse(jobCon.allJobsJson[index].totalSlots) *
                          100;
                  return InkWell(
                    onTap: () {
                      Get.to(A1AllJob(
                        jobId: jobCon.allJobsJson[index].jobId,
                        // profile: jobCon.allJobsJson[index].profile,
                        // name: jobCon.allJobsJson[index].name,
                        // description:
                        // jobCon.allJobsJson[index].description,
                        // joinFee: jobCon.allJobsJson[index].allJobsDataAppliFees,
                        // slotsLeft: jobCon.allJobsJson[index].slotsLeft,
                        // totalSlots: jobCon.allJobsJson[index].totalSlots,
                        isAllJobs: true,
                      ));
                    },
                    child: Container(
                      height: size.height * 0.21,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color(0xFFB5B5B5), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  jobCon.allJobsJson[index].profile,
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                jobCon.allJobsJson[index].name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
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
                              Expanded(
                                child: Text(
                                  jobCon.allJobsJson[index].description,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Color(0xFF000000),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF109E38),
                                ),
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Apply',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ProgressBar(
                            count: percentageBar /100,
                            width: 0.85,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${jobCon.allJobsJson[index].slotsLeft} slots left",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFF0000),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${jobCon.allJobsJson[index].totalSlots} slots",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Obx(
            () => ListView.builder(
                itemCount: jobCon.userJoinedJobsJson.length,
                itemBuilder: (context, index) {
                  var percentageBar =
                      double.parse(jobCon.userJoinedJobsJson[index].slotsLeft) /
                          double.parse(
                              jobCon.userJoinedJobsJson[index].totalSlots) *
                          100;
                  return InkWell(
                    onTap: () {
                      Get.to(A1AllJob(
                        jobId: jobCon.userJoinedJobsJson[index].jobId,
                        // profile: jobCon.userJoinedJobsJson[index].profile,
                        // name: jobCon.userJoinedJobsJson[index].name,
                        // description:
                        // jobCon.userJoinedJobsJson[index].description,
                        // joinFee: jobCon.userJoinedJobsJson[index].allJobsDataAppliFees,
                        // slotsLeft: jobCon.userJoinedJobsJson[index].slotsLeft,
                        // totalSlots: jobCon.userJoinedJobsJson[index].totalSlots,
                        isAllJobs: false,
                      ));
                    },
                    child: Container(
                      height: size.height * 0.21,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color(0xFFB5B5B5), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  jobCon.userJoinedJobsJson[index].profile,
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                jobCon.userJoinedJobsJson[index].name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
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
                              Expanded(
                                child: Text(
                                  jobCon.userJoinedJobsJson[index].description,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Color(0xFF000000),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.primary_color,
                                ),
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                child: const Text(
                                  'View',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ProgressBar(
                            count: percentageBar / 100,
                            width: 0.85,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${jobCon.userJoinedJobsJson[index].slotsLeft} spots left',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFF0000),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${jobCon.userJoinedJobsJson[index].totalSlots} spots',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
          // const A1UploadedJob(),
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
    // return const Scaffold(
    //   backgroundColor: Color(0xFFF2F2F2),
    //   body: Center(
    //     child: Text(
    //       'Coming Soon',
    //       textAlign: TextAlign.end,
    //       style: TextStyle(
    //         fontFamily: 'MontserratBold',
    //         color: colors.widget_color,
    //         fontSize: 24,
    //       ),
    //     ),
    //   ),
    // );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.count, required this.width})
      : super(key: key);
  final num count;
  final double width;

  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.of(context).size.width * width;

    return Stack(
      children: <Widget>[
        Container(
          height: 10,
          width: barWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xFFF9DDDC)),
        ),
        Container(
          height: 10.0,
          width: barWidth * count,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFFEB8765),
                  Color(0xFFD80803),
                ],
                // stops: [0.25, 0.5, 0.75, 1.0],
              )),
        ),
      ],
    );
  }
}
