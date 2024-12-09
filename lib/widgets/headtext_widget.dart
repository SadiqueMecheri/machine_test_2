import 'package:flutter/material.dart';

class headtextWidget extends StatelessWidget {
  String title;
  headtextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
