import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  final String link;

  UpdateDialog({Key? key, required this.link});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // set the background color for the screen
      body: Center(
        child: AlertDialog(
          title: const Text('Update Available'),
          content: const Text('A new version of the app is available. Please update to the latest version.'),
          actions: [
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                launch(link);
              },
            ),
          ],
        ),
      ),
    );
  }
}
