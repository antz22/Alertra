import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/login/login.dart';
import 'package:flutter_alertra/screens/student/home/student_home_page.dart';
import 'package:flutter_alertra/screens/teacher/home/teacher_home_page.dart';
import 'package:flutter_alertra/services/authentication_service.dart';
import 'package:flutter_alertra/widgets/custom_button.dart';
import 'package:flutter_alertra/widgets/custom_textfield.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  final schoolController = TextEditingController();
  var errText = "";
  var err = false;

  _register() async {
    Map data = await context.read<AuthenticationService>().registerUser(
        usernameController.text,
        passwordController.text,
        roleController.text,
        schoolController.text);
    if (data.containsKey('statusCode') &&
        data['statusCode'] != '200' &&
        data['statusCode'] != '201') {
      String key = data['body'].keys.elementAt(0);
      print(data['body'][key][0]!);
      setState(() {
        err = true;
        errText = data['body'][key][0];
      });
    } else {
      if (roleController.text == 'Teacher') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherHomePage(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHomePage(),
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
            const Spacer(),
            Column(
              children: [
                Image.asset('assets/images/alertra_white_text_logo.png'),
              ],
            ),
            const Spacer(),
            err
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2 * kDefaultPadding),
                    child: Column(
                      children: [
                        Text(
                          errText,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  )
                : const SizedBox(),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
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
                  const SizedBox(height: kDefaultPadding),
                  CustomTextField(
                    hintText: 'Role',
                    controller: roleController,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  CustomTextField(
                    hintText: 'School',
                    controller: schoolController,
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _register(),
              child: const CustomButton(
                purpose: 'other',
                text: 'REGISTER',
                fit: 'normal',
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontSize: 15.0,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
