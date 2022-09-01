import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEDF0F7),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(),
    );
  }
}
