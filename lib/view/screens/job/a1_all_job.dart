import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/job_con.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class A1AllJob extends StatefulWidget {
  const A1AllJob({super.key});

  @override
  State<A1AllJob> createState() => _A1AllJobState();
}

class _A1AllJobState extends State<A1AllJob>
    with SingleTickerProviderStateMixin {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();
  late TabController tabController;
  String gender = "";
  List<XFile> photo = [];

  final selectedColor = Colors.white;
  final tabs = [
    const Tab(text: 'Work'),
    const Tab(text: 'Joined user'),
    const Tab(text: 'Income'),
    const Tab(text: 'Result'),
  ];

  @override
  void initState() {
    super.initState();
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
      //       child: Image.asset(
      //         'assets/images/Group 18197.png',
      //         height: 10,
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Group 18200.png',
                      height: size.height * 0.07,
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
                      color: Color(0xFF000000),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Hi , I want logo design for beauty parlour can you create for me , i will pay for you',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFF000000),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 7,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xFFF9DDDC),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '10 spots left',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFFFF0000),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '20 spots',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF109E38),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: const Text(
                'Join ₹ 34',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    'Earn Income  Upto  ₹ 500 ',
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
              height: 1000,
              child: TabBarView(
                controller: tabController,
                children: const [
                  Work(),
                  JoinedUser(),
                  Income(),
                  Result(),
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
  const Work({super.key});

  @override
  State<Work> createState() => _WorkState();
}
class _WorkState extends State<Work> {
  final JobCon jobCon = Get.find<JobCon>();
  final PCC c = Get.find<PCC>();
  late TabController tabController;
  String gender = "";
  List<XFile> photo = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
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
                    child: PhotoDisplayWidget(photo: c.photo.value),
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 10,
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
                    gradient: LinearGradient(colors: [
                      Color(0xFFFFD88C),
                      Color(0xFFE9BC46),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
                const Text(
                  'Tamil',
                  textAlign: TextAlign.start,
                  style: TextStyle(
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
        });
  }
}

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}
class _IncomeState extends State<Income> {
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
          padding: const EdgeInsets.only(left: 20,right: 35),
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
              ),Text(
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
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFE3E3E3)))),
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
                      const Text(
                        '₹ 500',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 10,
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
                  child: index == 0 || index == 1 || index == 2 ? Image.asset(
                    index == 0 ? 'assets/images/gold-medal 1.png' : index == 1 ? 'assets/images/second 1.png' : 'assets/images/medal(1) 1.png',
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
                const Text(
                  'Tamil',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Color(0xFF000000),
                    fontSize: 18,
                  ),
                ),
                Expanded(child: Container()),
                const Text(
                  '₹ 500',
                  textAlign: TextAlign.start,
                  style: TextStyle(
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
        });
  }
}
