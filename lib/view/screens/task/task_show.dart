
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';

class TaskShow extends StatefulWidget {
  const TaskShow({Key? key}) : super(key: key);


  @override
  State<TaskShow> createState() => TaskShowState();
}

class TaskShowState extends State<TaskShow> {
  late SharedPreferences prefs;

  late String contact_us,image = "";

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        image = prefs.getString(Constant.IMAGE).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   // Optionally, you can set height and width for the container
          //   // height: 200,
          //   // width: 200,
          //   child: Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             Flexible(child: Container(
          //               width: 150.0,
          //               child: MaterialButton(
          //                 onPressed: () {
          //                   String text =
          //                       'Hello I need Help in Task';
          //
          //                   // Encode the text for the URL
          //                   String encodedText = Uri.encodeFull(text);
          //                   String uri =
          //                       'https://wa.me/$contact_us?text=$encodedText';
          //                   launchUrl(
          //                     Uri.parse(uri),
          //                     mode: LaunchMode.externalApplication,
          //                   );
          //                 },
          //                 color: colors.cc_green,
          //                 shape: const RoundedRectangleBorder(
          //                   borderRadius:
          //                   BorderRadius.all(Radius.circular(8.0)),
          //                 ),
          //                 child: Padding(
          //                   padding:
          //                   const EdgeInsets.only(top: 16.0, bottom: 16.0),
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: const <Widget>[
          //                       Text(
          //                         'Get Help',
          //                         style: TextStyle(
          //                           color: colors.white,
          //                           fontSize: 16.0,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),),
          //
          //
          //           ],
          //         ),
          //         SizedBox(height: 5),
          //         GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) {
          //                   return FindColor(); // Replace NextPage with the actual page you want to navigate to
          //                 },
          //               ),
          //             );
          //           },
          //           child:Image.asset(
          //             'assets/images/color_task.png', // Replace this with the correct path to your asset image
          //             fit: BoxFit.contain, // Adjust the fit as needed
          //             height: 200, // Set the desired height of the image
          //             width: 200,  // Set the desired width of the image
          //           ),
          //         ),
          //
          //
          //
          //
          //
          //         SizedBox(height: 10), // Add some space between the image and the text
          //
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(

            child: Result(),
          ),


        ],
      ),
    );
  }

  Result() {}

}
