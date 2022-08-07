import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.verbose = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool verbose;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: const Color(0xFFBEC3CD),
      obscureText: hintText.contains('Password') ? true : false,
      style: const TextStyle(
        color: Color(0xFFBEC3CD),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Color(0xFFBEC3CD),
          fontSize: 16,
        ),
        hintText: hintText,
        filled: false,
        icon: hintText.contains('Password')
            ? const Icon(
                Icons.lock,
                color: Color(0xFFBEC3CD),
              )
            : const Icon(
                Icons.email,
                color: Color(0xFFBEC3CD),
              ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBEC3CD),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBEC3CD),
          ),
        ),
      ),
      keyboardType: verbose ? TextInputType.multiline : TextInputType.text,
      maxLines: verbose ? 10 : 1,
    );
  }
}
