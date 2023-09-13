import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/notification_data.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late List<NotificationData> notificationData = [];
  late SharedPreferences prefs;
  Future<List<NotificationData>> _getWithdrawalsData() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)!,
    };

    String response = await apiCall(Constant.NOTIFICATION_LIST_URL,bodyObject);

    final jsonsData = jsonDecode(response);
    notificationData.clear();

    for (var Data in jsonsData['data']) {
      final id = Data['id'];
      final title = Data["title"];
      final description = Data['description'];
      final link = Data['link'];
      final datetime = Data['datetime'];

      NotificationData data = NotificationData(id, title, description,link, datetime);
      notificationData.add(data);
    }
    return notificationData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getWithdrawalsData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (notificationData.isEmpty) {
          return Center(
              child: Column(
                children: const [
                 // CircularProgressIndicator(color: colors.primary),
                ],
              ));
        } else {
          return  SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notificationData.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: colors.cc_velvet,
                        margin: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 5, top: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${notificationData[index].title}",
                                style: const TextStyle(
                                  color: colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5), // Adding some spacing between the two Text widgets
                              Text(
                                "${notificationData[index].description}",
                                style: TextStyle(
                                  color: colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 10, // You can adjust the font size as needed
                                ),
                              ),
                              if (notificationData[index].link.isNotEmpty)
                              MaterialButton(
                                height: 25,
                                color: colors.primary,
                                onPressed: () {
                                  String uri =
                                      "${notificationData[index].link}";
                                  launchUrl(
                                    Uri.parse(uri),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Open',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: colors.white,
                                        fontFamily: "Montserra")),
                              ),
                              Text(
                                "${notificationData[index].datetime}",
                                style: TextStyle(
                                  color: colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 10, // You can adjust the font size as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              },
            ),
          );
        }
      },
    );
  }
}
