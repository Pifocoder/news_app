import 'package:flutter/material.dart';

class TitleWithUnderline extends StatelessWidget {
  final String title;

  const TitleWithUnderline({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 2.0),
        const Divider(
          thickness: 2.0,
          color: Colors.grey,
        ),
        const SizedBox(height: 2.0),
      ],
    );
  }
}
