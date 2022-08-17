import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/main/feed/create_report.dart';
import 'package:flutter_alertra/screens/teacher/home/teacher_home_page.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 20,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search reports',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFB7B7B7),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2 * kDefaultPadding),
          const Text('Today', style: TextStyle(fontSize: 18)),
          const SizedBox(height: kDefaultPadding),
          const Text(
            'ALERTS',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.red),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: ListView(
              children: [
                Material(
                  elevation: 16,
                  shadowColor: Color.fromARGB(255, 255, 170, 170),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    tileColor: Colors.white,
                    leading: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Gamer causes lighting storm, dies instantly',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                        'Imposter on the run at 50 Fortnite drive, please take caution.'),
                    trailing: const Text(
                      '11:21 am',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          const Text('Reports', style: TextStyle(fontSize: 18)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateReport(),
                ),
              );
            },
            child: const Text('Create Report'),
          ),
        ],
      ),
    );
  }
}
