import 'package:a1_ads/util/Color.dart';
import 'package:flutter/material.dart';

class InvestScreen extends StatefulWidget {
  const InvestScreen({super.key});

  @override
  State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width:
            MediaQuery.of(context).size.width, // Set width to the screen width
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
        padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Post Ad Earn Money Without Work",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(height: 10,),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white60),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/images (10) 1.png',height: size.height * 0.1,),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Local Ads",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "Daily views = 100",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.yellow,
                              fontFamily: "Montserrat"),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "Daily income  = Rs. 100",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.yellow,
                              fontFamily: "Montserrat"),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "Total Earnings = Rs.80",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Purchase ₹50",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontFamily: "Montserrat"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Expanded(child: Container()),
                    // const Text(
                    //   "Purchase ₹50",
                    //   style: TextStyle(
                    //       fontSize: 10,
                    //       color: Colors.red,
                    //       fontFamily: "Montserrat"),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
