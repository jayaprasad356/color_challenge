import 'package:flutter/material.dart';

import 'Helper/Color.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                color: colors.white,
                margin: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: 45,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: colors.cc_green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            const Text(
                              "GREEN",
                              style: TextStyle(
                                  fontFamily: "Montserra",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: colors.black),
                            ),
                            Expanded(child: Container()),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            const Text(
                              "2023-03-10",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: colors.black),
                            ),
                            const Text(
                              "12 PM",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: colors.black),
                            ),
                            Expanded(child: Container()),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
