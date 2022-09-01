import 'package:flutter/material.dart';

class Learn extends StatelessWidget {
  const Learn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Safety Tips",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(height: 16),
            _learnCard(
              text: "Be aware of your surroundings",
              location: "top",
              icon: Icons.visibility,
            ),
            _learnCard(
              text: "Know travel routes to and from school",
              location: "middle",
              icon: Icons.map,
            ),
            _learnCard(
              text: "Learn school emergency procedures",
              location: "bottom",
              icon: Icons.warning,
            ),
            const SizedBox(height: 16),
            const Text(
              "Emergency Contact",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(height: 16),
            _learnCard(
              text: "Police",
              location: "top",
              icon: Icons.local_police,
            ),
            _learnCard(
              text: "School Contact",
              location: "middle",
              icon: Icons.school,
            ),
            _learnCard(
              text: "Parent/Guardian",
              location: "bottom",
              icon: Icons.call,
            ),
          ],
        ),
      ),
    );
  }

  Widget _learnCard(
      {required String text,
      required String location,
      required IconData icon}) {
    BorderRadiusGeometry radius = location == "top"
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        : location == "bottom"
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.zero;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: radius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF4AB1FC),
              size: 40,
            ),
            const SizedBox(width: 28),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      elevation: 0,
    );
  }
}
