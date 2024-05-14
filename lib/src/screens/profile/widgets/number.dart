import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 14.0,
          ),
        ),
      ),
    );
  }
}
