import 'package:a1_ads/util/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class JobDetail extends StatefulWidget {
  final String name;
  final String company_name;
  final String location;
  final String salary;
  final List<String> job_type;
  final List<String> job_timing;
  const JobDetail({super.key, required this.name, required this.company_name, required this.location, required this.salary, required this.job_type, required this.job_timing});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  InlineSpan toInlineSpan(final String text) {
    return TextSpan(
      children: [
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.circle,
              size: 8,
              color: Colors.white,
            ),
          ),
        ),
        TextSpan(
          text: '$text\n',
          style: const TextStyle(
            fontFamily: 'MontserratLite',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Container container(Widget child) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFDAE4F6),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text(
          'Job Detail',
          style: TextStyle(
            fontFamily: 'MontserratBold',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
          Text(
                widget.name,
                style: const TextStyle(
                  fontFamily: 'MontserratBold',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                 widget.company_name,
                style: const TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.location,
                    style: const TextStyle(
                      fontFamily: 'MontserratLite',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pay',
                    style: TextStyle(
                      fontFamily: 'MontserratLite',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              container(
                 Text(
                  widget.salary,
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
              widget.job_type.isEmpty ? const SizedBox() : const Row(
                children: [
                  Icon(
                    Icons.work,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Job Type',
                    style: TextStyle(
                      fontFamily: 'MontserratLite',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              widget.job_type.isEmpty ? const SizedBox() : const SizedBox(
                height: 10,
              ),
              widget.job_type.isEmpty ? const SizedBox() : SizedBox(
                height: 28,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  itemCount: widget.job_type.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: container(
                        Text(
                          widget.job_type[index],
                          style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.primary_color,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.job_timing.isEmpty ? const SizedBox() : const Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Shift and schedule',
                    style: TextStyle(
                      fontFamily: 'MontserratLite',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              widget.job_timing.isEmpty ? const SizedBox() : const SizedBox(
                height: 10,
              ),
              widget.job_timing.isEmpty ? const SizedBox() : SizedBox(
                height: 28,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.job_timing.length,
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: container(
                          Text(
                            widget.job_timing[index],
                          style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.primary_color,
                          ),
                        ),
                                            ),
                      );
                  }
                ),
              ),
              widget.job_timing.isEmpty ? const SizedBox() : const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Qualification Required',
                    style: TextStyle(
                      fontFamily: 'MontserratLite',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Any Graduate',
                style: TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Skills Required',
                style: TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    toInlineSpan('HTML'),
                    toInlineSpan('C++'),
                    toInlineSpan('JAVA'),
                  ],
                ),
              ),
              const Text(
                'Detail',
                style: TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    toInlineSpan('Designing and building responsive and mobile-friendly websites optimised for different devices and browsers'),
                    toInlineSpan('Writing clean, efficient, and well-documented code using languages such as HTML, CSS,PHP & Wordpress'),
                    toInlineSpan('Implementing and maintaining website content management systems'),
                    toInlineSpan('Staying up-to-date with the latest web technologies and industry trends to ensure the website is current and secure'),
                  ],
                ),
              ),
              const Text(
                'Experience',
                style: TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    toInlineSpan('CSS: 1 year (Preferred)'),
                    toInlineSpan('HTML5: 1 year (Preferred)'),
                    toInlineSpan('total work: 1 year (Preferred)'),
                  ],
                ),
              ),
              const Text(
                'Ability to Commute',
                style: TextStyle(
                  fontFamily: 'MontserratLite',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    toInlineSpan('Coimbatore, Tamil Nadu (Required)'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/btnbg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
