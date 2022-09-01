import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: const Text(
          'Account',
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
