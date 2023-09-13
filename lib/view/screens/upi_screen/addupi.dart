import 'package:flutter/material.dart';

import '../../../util/Color.dart';

class addupi extends StatefulWidget {
  const addupi({Key? key}) : super(key: key);

  @override
  State<addupi> createState() => _addupiState();
}

class _addupiState extends State<addupi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              AppBar(
                centerTitle: true,
                leading:
                    const Icon(Icons.arrow_back_outlined, color: colors.black),
                title: const Text(
                  'Add UPI',
                  style: TextStyle(
                      fontSize: 24,
                      color: colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                backgroundColor: colors.white,
              ),
              // todo card view
              Card(
                color: colors.cc_button_grey,
                margin: const EdgeInsets.only(
                    right: 15, left: 15, bottom: 10, top: 10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: colors.primary),
                                    height: 20,
                                    width: 40,
                                    child: const Center(
                                      child: Text(
                                        "UPI",
                                        style: TextStyle(
                                            color: colors.white,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 40, bottom: 10),
                                    child: Text("Tamilarasan",
                                        style: TextStyle(
                                            color: colors.cc_greyText,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: Text("Tamilarasan@okasix",
                                        style: TextStyle(
                                            color: colors.cc_greyText,
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 55.0,
                                      top: 0,
                                      bottom: 10,
                                    ),
                                    child: Image.asset(
                                      "assets/images/bin.png",
                                      height: 24,
                                      width: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/images/corner.png",
                          height: 40, width: 40),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  // Perform some action
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
                      '+ New UPI',
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: const Material(
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: colors.white,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colors.primary),
                                ),
                                labelText: "Enter Name",
                                labelStyle: TextStyle(color: colors.greyss)),
                            style:
                                TextStyle(backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: const Material(
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colors.primary),
                                ),
                                labelText: "UPI address",
                                labelStyle: TextStyle(color: colors.greyss)),
                            style:
                                TextStyle(backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: const Material(
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colors.primary),
                                ),
                                labelText: "Confirm UPI address",
                                labelStyle: TextStyle(color: colors.greyss)),
                            style:
                                TextStyle(backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          // Perform some action
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 10, bottom: 20),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Verify.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
