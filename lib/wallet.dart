import 'package:color_challenge/addupi.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.white,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "My Coins",
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.greyss,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "₹ 8500.00",
                      style: TextStyle(
                          fontSize: 24,
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserra"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: colors.cc_button_grey,
                        //DecorationImage
                        border: Border.all(
                          color: colors.cc_list_grey,
                        ), //Border.all
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          ' +  Add UPI',
                          style: TextStyle(color: colors.cc_greyText),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Amount",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 4),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: '₹ Please Input',
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: const TextSpan(
                            text: "Minimum : ",
                            style: TextStyle(
                                color: colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                            children: [
                              TextSpan(
                                text: "₹ 100",
                                style: TextStyle(
                                    color: colors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const addupi()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Verify.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Withdrawal',
                            style: TextStyle(
                                fontSize: 14,
                                color: colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Record",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Card(
                          color: colors.cc_button_grey,
                          margin: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 10),
                          child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10.0),
                                            child: Text("Coins",
                                                style: TextStyle(
                                                    color: colors.cc_greyText,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            child: Text("₹ 800",
                                                style: TextStyle(
                                                    color: colors.black,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text("Time",
                                                style: TextStyle(
                                                    color: colors.cc_greyText,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text("01/23  10:36",
                                                style: TextStyle(
                                                    color: colors.black,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                top: 10,
                                                bottom: 10),
                                            child: Text("State",
                                                style: TextStyle(
                                                    color: colors.cc_greyText,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 15, bottom: 10),
                                            child: Text(
                                              "Completed",
                                              style: TextStyle(
                                                  color: colors.cc_green,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 4.0, bottom: 4),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Fee : ",
                                          style: TextStyle(
                                              color: colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat"),
                                          children: [
                                            TextSpan(
                                              text: "₹ 30",
                                              style: TextStyle(
                                                  color: colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      "Montserconst rat"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Tamilarasan",
                                            style: TextStyle(
                                                color: colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 12, bottom: 15),
                                          child: Text(
                                            "tamil@okaxis",
                                            style: TextStyle(
                                                color: colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
