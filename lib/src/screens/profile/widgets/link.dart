import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Link({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      RichText(
        text: TextSpan(
          text: text,
          style:  const TextStyle(color: Colors.black54, decoration: TextDecoration.underline),
          recognizer:  TapGestureRecognizer()
            ..onTap = onPressed,
        ),
      );
  }
}
