import 'dart:async';

import 'package:a1_ads/controller/full_time_page_con.dart';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/job/jobs.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class A1AllJob extends StatefulWidget {
  final String jobId;
  // final String profile;
  // final String name;
  // final String description;
  // final String joinFee;
  // final String slotsLeft;
  // final String totalSlots;
  final bool isAllJobs;
  const A1AllJob({
    super.key,
    required this.jobId,
    // required this.profile,
    // required this.name,
    // required this.description,
    // required this.joinFee,
    required this.isAllJobs,
    // required this.slotsLeft,
    // required this.totalSlots
  });

  @override
  State<A1AllJob> createState() => _A1AllJobState();
}

class _A1AllJobState extends State<A1AllJob>
    with SingleTickerProviderStateMixin {
  final JobCon jobCon = Get.find<JobCon>();
  final FullTimePageCont fullTimePageCont = Get.find<FullTimePageCont>();
  final PCC c = Get.find<PCC>();
  late TabController tabController;
  // String gender = "";
  List<XFile> photo = [];
  late SharedPreferences prefs;

  final selectedColor = Colors.white;
  final tabs = [
    const Tab(text: 'Work'),
    // const Tab(text: 'Joined user'),
    // const Tab(text: 'Income'),
    // const Tab(text: 'Result'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    print("tabController ${tabController.index}");
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    setState(() {
      jobCon.jobsList(widget.jobId);
    });
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
    // var percentageBar =
    //     double.parse(jobCon.jobsListDataSlotsLeft.toString()) / double.parse(jobCon.jobsListDataTotalSlots.toString()) * 100;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        title: Obx(
          () => Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10000),
                child: Image.network(
                  jobCon.jobsListDataProfile.toString(),
                  height: size.height * 0.06,
                  width: size.height * 0.06,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                jobCon.jobsListDataName.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF000000),
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 5),
            child: Image.asset(
              'assets/images/Group 18197.png',
              height: 10,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Obx(
                  () => Text(
                    jobCon.jobsListDataDescription.toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => ProgressBar(
                count: jobCon.percentageBar / 100,
                width: 0.9,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      '${jobCon.jobsListDataSlotsLeft.toString()} spots left',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFFFF0000),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      '${jobCon.jobsListDataTotalSlots.toString()} spots',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => SizedBox(
                height: jobCon.jobsListDataAppliedStatus.toString() == '0'
                    ? 20
                    : size.height * 0.14,
              ),
            ),
            Obx(
              () => jobCon.jobsListDataAppliedStatus.toString() == '0'
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Entry fees',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFF4F4F53),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => jobCon.jobsListDataAppliedStatus.toString() == '0'
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => jobCon.jobsListDataAppliedStatus.toString() == '0'
                  ? InkWell(
                      onTap: () {
                        fullTimePageCont.showLoadingIndicator(context);
                        Timer(const Duration(seconds: 5), () async {
                          jobCon.applyJobs(widget.jobId);
                          fullTimePageCont.hideLoadingIndicator(context);
                        });
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF109E38),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Join ₹ ${jobCon.jobsListDataAppliFees.toString()}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFFFFFFFF),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => jobCon.jobsListDataAppliedStatus.toString() == '0'
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(),
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFDD8D8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/profits 1.png',
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Earn Income Upto ₹ 500 ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
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
                fontSize: 16,
              ),
              tabs: tabs,
              onTap: (index) => handleTabSelection(index),
            ),
            SizedBox(
              height: size.height * 0.86,
              child: TabBarView(
                controller: tabController,
                children: [
                  Obx(() => Work(
                        jobsListDataAppliedStatus:
                            jobCon.jobsListDataAppliedStatus.toString(),
                        jobsListDataUploadStatus:
                            jobCon.jobsListDataUploadStatus.toString(),
                        jobsListDataJobUpdate:
                            jobCon.jobsListDataJobUpdate.toString(),
                        jobsListDataJobId: jobCon.jobsListDataJobId.toString(),
                        isAllJobs: widget.isAllJobs,
                      )),
                  // JoinedUser(),
                  // Income(),
                  // Result(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Work extends StatefulWidget {
  final String jobsListDataAppliedStatus;
  final String jobsListDataUploadStatus;
  final String jobsListDataJobUpdate;
  final String jobsListDataJobId;
  final bool isAllJobs;
  const Work({
    super.key,
    required this.jobsListDataAppliedStatus,
    required this.jobsListDataUploadStatus,
    required this.jobsListDataJobUpdate,
    required this.jobsListDataJobId,
    required this.isAllJobs,
  });

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();
  late TabController tabController;
  String gender = "";
  List<XFile> photo = [];
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.jobsListDataAppliedStatus == '0'
        ? widget.jobsListDataUploadStatus == '1'
            ? Column(
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Image.asset(
                    'assets/images/success 3.png',
                    height: size.height * 0.15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Uploaded Success',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/businessman 1.png',
                        height: size.height * 0.05,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Result will announce datetime',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF000000),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Once you have this description, you can share it with a professional graphic designer or use it as a brief on logo design platforms. They can then use this information to create a custom logo that aligns with your vision for the beauty parlor.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/burning 2.png',
                          height: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFF000000),
                              fontSize: 16,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Deadline :',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                ),
                              ),
                              TextSpan(
                                text: ' 01- 01-2024 03:00 AM',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.isAllJobs == true
                        ? const SizedBox()
                        :  widget.jobsListDataUploadStatus == '0'
                              ? const Align(
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
                                )
                              : const SizedBox(),
                    SizedBox(
                      height: widget.jobsListDataUploadStatus == '0' ? 10 : 0,
                    ),
                     widget.isAllJobs == true
                          ? const SizedBox()
                          : widget.jobsListDataUploadStatus == '0'
                              ? Obx(
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
                                        child: PhotoDisplayWidget(
                                            photo: c.photo.value),
                                      ),
                                    ),
                                  ),
                              )
                              : const SizedBox(),
                    widget.isAllJobs == true
                        ? const SizedBox()
                        : SizedBox(
                            height:
                                widget.jobsListDataUploadStatus == '0' ? 20 : 0,
                          ),
                    widget.isAllJobs == true
                        ? const SizedBox()
                        : widget.jobsListDataUploadStatus == '0'
                            ? Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    prefs =
                                        await SharedPreferences.getInstance();
                                    String userId =
                                        prefs.getString(Constant.ID)!;
                                    debugPrint("userId: $userId");
                                    var image = c.photo.value;
                                    debugPrint("photo: ${image}");
                                    jobCon.jobsUpload(widget.jobsListDataJobId,
                                        XFile(c.photo.value.toString()));
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
                              )
                            : const SizedBox(),
                  ],
                ),
              )
        : widget.jobsListDataJobUpdate == '0'
            ? Column(
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  const Text(
                    "Work not Start Yet",
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : widget.jobsListDataUploadStatus == '1'
                ? Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Image.asset(
                        'assets/images/success 3.png',
                        height: size.height * 0.15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Uploaded Success',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF000000),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/businessman 1.png',
                            height: size.height * 0.05,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Result will announce datetime',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFF000000),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Once you have this description, you can share it with a professional graphic designer or use it as a brief on logo design platforms. They can then use this information to create a custom logo that aligns with your vision for the beauty parlor.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFF000000),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/burning 2.png',
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Deadline :',
                                    style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' 01- 01-2024 03:00 AM',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.isAllJobs == true
                            ? const SizedBox()
                            : widget.jobsListDataUploadStatus == '0'
                                ? const Align(
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
                                  )
                                : const SizedBox(),
                        SizedBox(
                          height:
                              widget.jobsListDataUploadStatus == '0' ? 10 : 0,
                        ),
                        widget.isAllJobs == true
                            ? const SizedBox()
                            : widget.jobsListDataUploadStatus == '0'
                                ? Obx(
                          () => Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: SizedBox(
                                          height: size.height * 0.2,
                                          width: size.width * 0.7,
                                          child: InkWell(
                                            onTap: () {
                                              // c.pickImageFromGallery();
                                              c.gallery().then((value) {
                                                picture:
                                                photo;
                                              });
                                              print("photos : ${c.photo}");
                                            },
                                            child: PhotoDisplayWidget(
                                                photo: c.photo.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                )
                                : const SizedBox(),
                        widget.isAllJobs == true
                            ? const SizedBox()
                            : SizedBox(
                                height: widget.jobsListDataUploadStatus == '0'
                                    ? 20
                                    : 0,
                              ),
                        widget.isAllJobs == true
                            ? const SizedBox()
                            : widget.jobsListDataUploadStatus == '0'
                                ? Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () async {
                                        prefs = await SharedPreferences
                                            .getInstance();
                                        String userId =
                                            prefs.getString(Constant.ID)!;
                                        debugPrint("userId: $userId");
                                        var image = c.photo.value?.path;
                                        debugPrint(
                                            "photo: ${c.photo.value?.path}");
                                        jobCon.jobsUpload(
                                            widget.jobsListDataJobId,
                                            c.photo.value as XFile);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: size.width * 0.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                  )
                                : const SizedBox(),
                      ],
                    ),
                  );
  }
}

class JoinedUser extends StatefulWidget {
  const JoinedUser({super.key});

  @override
  State<JoinedUser> createState() => _JoinedUserState();
}

class _JoinedUserState extends State<JoinedUser> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobCon.jobsJoinedUsers("1");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => ListView.builder(
          itemCount: jobCon.joinedUserJson.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE3E3E3)))),
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 12,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE3E3E3),
                        ),
                      ),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFD88C),
                            Color(0xFFE9BC46),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${index + 1}.",
                    style: const TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    jobCon.joinedUserJson[index].name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    'Joined',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF161C7E),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/winner 1.png',
                    height: 25,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobCon.jobsIncome("1");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 25,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE3E3E3),
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 20, right: 35),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rank',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF4F4F53),
                  fontSize: 12,
                ),
              ),
              Text(
                'Winnings',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF4F4F53),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
                itemCount: jobCon.jobIncomeJson.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xFFE3E3E3)))),
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 12,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFE3E3E3),
                              ),
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFD88C),
                                  Color(0xFFE9BC46),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${index + 1}",
                          style: const TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFF000000),
                            fontSize: 18,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          jobCon.jobIncomeJson[index].income,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFF161C7E),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/winner 1.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobCon.jobsResult("1");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => ListView.builder(
          itemCount: jobCon.jobResultJson.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE3E3E3)))),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 25,
                    alignment: Alignment.center,
                    child: index == 0 || index == 1 || index == 2
                        ? Image.asset(
                            index == 0
                                ? 'assets/images/gold-medal 1.png'
                                : index == 1
                                    ? 'assets/images/second 1.png'
                                    : 'assets/images/medal(1) 1.png',
                            height: 25,
                          )
                        : Text(
                            "${index + 1}.",
                            style: const TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFF000000),
                              fontSize: 18,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    jobCon.jobResultJson[index].name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    jobCon.jobResultJson[index].position,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF161C7E),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
