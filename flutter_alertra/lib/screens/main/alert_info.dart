import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';

class AlertInfo extends StatelessWidget {
  const AlertInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const SizedBox(height: 2 * kDefaultPadding),
            Row(
              children: const [
                Text(
                  'ALERT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                ),
                Spacer(),
                Text(
                  '11:21am',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 0.5),
            const Text(
              'Gamer causes lighting storm, dies instantly',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 0.75),
            Row(
              children: [
                Container(
                  height: 30.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF03EAFD),
                        Color(0xFF4AB1FC),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "Weather Emergency",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Container(
                  height: 30.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4D4D),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "High Urgency",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 1.2),
            const Text(
              "Anthoinzee, the thing, has spotted aZAMMMM and Suchiscrit eating ice cream in the cottage. Police are investigating why. Do not approach said targets.",
              style: TextStyle(
                fontSize: 18.0,
                height: 1.5,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 1.7),
            Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  color: Color(0xFFB4B4B4),
                ),
                const SizedBox(width: kDefaultPadding * 0.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "68 Belle Glades Ln, Skillman, NJ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 0.1),
                    Text(
                      "Tap to view in Maps",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
