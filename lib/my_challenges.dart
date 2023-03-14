import 'package:color_challenge/muChallenges.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'myResults.dart';

class MyChallenges extends StatefulWidget {
  const MyChallenges({Key? key}) : super(key: key);

  @override
  State<MyChallenges> createState() => _MyChallengesState();
}

class _MyChallengesState extends State<MyChallenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyChallenge()
    );
  }
}
