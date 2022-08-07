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
          ),
        ),
        const Text(
          "•",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
