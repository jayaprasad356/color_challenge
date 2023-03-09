import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';

class BlinkingText extends StatefulWidget {
  final String text;

  const BlinkingText({required this.text});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText> {
  late Stream<Color> _colorStream;

  @override
  void initState() {
    super.initState();
    _colorStream = Stream.periodic(const Duration(milliseconds: 500), (count) {
      return count % 2 == 0 ? colors.primary : Colors.white;
    }).take(60);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color>(
      stream: _colorStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            color: snapshot.data!,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        );
      },
    );
  }
}
