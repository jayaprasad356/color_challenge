import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/view/screens/job/job_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

class JobFinder extends StatefulWidget {
  const JobFinder({super.key});

  @override
  State<JobFinder> createState() => _JobFinderState();
}

class _JobFinderState extends State<JobFinder> {
  List<bool> isHovered = List.generate(webLinkList.length, (index) => false);
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  // final GlobalKey buttonKey = GlobalKey();
  int currentIndex = -1;
  bool isSelected = false;
  String selectedValue = "";

  final List<String> popupMenuValue = ["save", "help"];

  Container container(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: child,
    );
  }

  void _updateHover(int index, bool hover) {
    setState(() {
      isHovered[index] = hover;
    });
  }

  void scrollToIndex(int index) {
    scrollController.animateTo(
      index * 100.0, // Adjust the value based on your item height
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void showPopupMenu(BuildContext context, int index, Key buttonKey) async {
    final RenderBox button = (buttonKey as GlobalKey).currentContext?.findRenderObject() as RenderBox;

    if (button == null) {
      return;
    }

    final Offset position = button.localToGlobal(Offset.zero);

    final String? result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + button.size.width,
        position.dy + button.size.height,
      ),
      items: popupMenuValue.map((value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    if (result != null) {
      // Handle the selected value here
      print('Selected value: $result$index');
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Find for Job...', // Hint text
              //     hintStyle: const TextStyle(
              //         fontFamily: 'MontserratLight',
              //         color: Color(0xFF9AA0B4),
              //         fontSize: 14),
              //     fillColor: Colors.white,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         width: 1,
              //         color: Color(0xFFEFEFEF),
              //       ),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         width: 1,
              //         color: Color(0xFFEFEFEF),
              //       ),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     prefixIcon: const Icon(Icons.search_rounded),
              //   ),
              //   style: const TextStyle(
              //       fontFamily: 'MontserratBold',
              //       color: Colors.black54,
              //       fontSize: 14),
              // ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: webLinkList.length,
                itemBuilder: (context, index) {
                  Key buttonKey = GlobalKey();
                  return Transform.scale(
                    scale: index == currentIndex ? 1.0 : 0.97,
                    child: InkWell(
                      onTap: isSelected == true
                          ? () {
                              debugPrint('isSelected');
                            }
                          : () async {
                              setState(() {
                                currentIndex = index;
                                isSelected = true;
                              });
                              await Future.delayed(const Duration(seconds: 1));
                              Get.to(JobDetail(
                                  name: webLinkList[index]['name'],
                                  company_name: webLinkList[index]['company_name'],
                                  location: webLinkList[index]['location'],
                                  salary: webLinkList[index]['salary'],
                                  job_type: webLinkList[index]['job_type'],
                                  job_timing: webLinkList[index]['job_timing']
                              ));
                              scrollToIndex(index);
                              setState(() {
                                isSelected = false;
                              });
                              pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: index == currentIndex
                              ? colors.cc_velvet
                              : Colors.transparent,
                          border: Border.all(
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.redAccent,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  webLinkList[index]['name'],
                                  style: const TextStyle(
                                    fontFamily: 'MontserratBold',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  key: buttonKey,
                                  onPressed: () {
                                    showPopupMenu(context,index, buttonKey);
                                  },
                                  highlightColor: Colors.deepPurpleAccent,
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                // GradientText(
                                //   webLinkList[index][2],
                                //   colors: const [
                                //     Color(0xFF00BED5),
                                //     Color(0xFF5BCF59)
                                //   ],
                                //   style: GoogleFonts.akshar(
                                //     textStyle: const TextStyle(
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.bold,
                                //       color: Color(0xFFDAE4F6),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              webLinkList[index]['company_name'],
                              style: const TextStyle(
                                fontFamily: 'MontserratLite',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              webLinkList[index]['location'],
                              style: const TextStyle(
                                fontFamily: 'MontserratLite',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            container(
                              Text(
                                webLinkList[index]['salary'],
                                style: const TextStyle(
                                  fontFamily: 'MontserratBold',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: colors.primary_color,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            webLinkList[index]['job_type'].length == 0
                                ? const SizedBox()
                                : SizedBox(
                                    height: 28,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          webLinkList[index]['job_type'].length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, subIndex1) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: container(
                                            Text(
                                              webLinkList[index]['job_type']
                                                  [subIndex1],
                                              style: const TextStyle(
                                                fontFamily: 'MontserratBold',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: colors.primary_color,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            webLinkList[index]['job_timing'].length == 0
                                ? const SizedBox()
                                : SizedBox(
                                    height: 28,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: webLinkList[index]
                                                ['job_timing']
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, subIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child: container(
                                              Text(
                                                webLinkList[index]['job_timing']
                                                    [subIndex],
                                                style: const TextStyle(
                                                  fontFamily: 'MontserratBold',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: colors.primary_color,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              webLinkList[index]['description'],
                              style: const TextStyle(
                                fontFamily: 'MontserratLite',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
