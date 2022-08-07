import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final String text;

  const PageButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "•",
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }
}
