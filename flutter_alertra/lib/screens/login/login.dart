import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/sign_up/sign_up.dart';
import 'package:flutter_alertra/screens/student/home/student_home_page.dart';
import 'package:flutter_alertra/screens/teacher/home/teacher_home_page.dart';
import 'package:flutter_alertra/services/authentication_service.dart';
import 'package:flutter_alertra/widgets/custom_button.dart';
import 'package:flutter_alertra/widgets/custom_textfield.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.isFirstTime = false}) : super(key: key);

  final bool isFirstTime;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  _signIn() async {
    Map<String, dynamic> response = await context
        .read<AuthenticationService>()
        .signIn(usernameController.text, passwordController.text);

    if (response['statusCode'] != '200') {
      String key = response['body'].keys.elementAt(0);
      print(response['body'][key][0]!);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? role = await prefs.getString('role');
      String? school = await prefs.getString('role');
      if (role == 'Teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TeacherHomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentHomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF13233A),
            Color(0xFF3C506D),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.125 * MediaQuery.of(context).size.height),
            Column(
              children: [
                Image.asset('assets/images/alertra_white_text_logo.png'),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 2 * kDefaultPadding,
                  vertical: 4 * kDefaultPadding),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Username',
                    controller: usernameController,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  CustomTextField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _signIn(),
              child: const CustomButton(
                  purpose: 'other', text: 'LOG IN', fit: 'normal'),
            ),
            const SizedBox(height: kDefaultPadding),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              child: const Text(
                'Create an account',
                style: TextStyle(
                  color: Color(0xFFBEC3CD),
                  fontSize: 15.0,
                ),
              ),
            ),
            // ================================================
            // ================================================
            // ======== ONLY FOR DEVELOPMENT PURPOSE ==========
            // ================================================
            // ================================================
            const SizedBox(height: kDefaultPadding),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentHomePage(),
                  ),
                );
              },
              child: const Text(
                'Student Home Page',
                style: TextStyle(
                  color: Color(0xFFBEC3CD),
                  fontSize: 15.0,
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherHomePage(),
                  ),
                );
              },
              child: const Text(
                'Teacher Home Page',
                style: TextStyle(
                  color: Color(0xFFBEC3CD),
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
