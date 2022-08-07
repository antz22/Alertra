import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Alertra',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              Container(
                child: Column(
                  children: const [
                    Text(
                      'Feed',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("𐩐", style: TextStyle(fontSize: 30, color: Colors.grey),),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
