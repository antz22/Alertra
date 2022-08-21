import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/models/alert.dart';

class AlertInfo extends StatelessWidget {
  const AlertInfo({
    Key? key,
    required this.alert,
  }) : super(key: key);

  final Alert alert;

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
              children: [
                const Text(
                  'ALERT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                Text(
                  alert.time.substring(0, 7),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 0.5),
            Text(
              alert.headline,
              style: const TextStyle(
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
                    children: [
                      Text(
                        "${alert.priority.toUpperCase()[0] + alert.priority.substring(1)} Urgency",
                        style: const TextStyle(
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
            Text(
              alert.content,
              style: const TextStyle(
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
