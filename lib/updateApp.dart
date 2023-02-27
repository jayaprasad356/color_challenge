import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {

  UpdateDialog({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // set the background color for the screen
      body: Center(
        child: AlertDialog(
          title: Text('Update Available'),
          content: Text('A new version of the app is available. Please update to the latest version.'),
          actions: [
            TextButton(
              child: Text('Update'),
              onPressed: () {
                launch("http://t.me/Colorchallengeapp1");
              },
            ),
          ],
        ),
      ),
    );
  }
}
