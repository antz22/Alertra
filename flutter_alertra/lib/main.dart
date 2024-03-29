import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alertra/screens/login/login.dart';
import 'package:flutter_alertra/screens/student/home/student_home_page.dart';
import 'package:flutter_alertra/screens/teacher/home/teacher_home_page.dart';
import 'package:flutter_alertra/services/APIServices.dart';
import 'package:flutter_alertra/services/authentication_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationService()),
        Provider(create: (context) => APIServices()),
      ],
      child: MaterialApp(
        title: 'Alertra',
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  AuthenticationWrapper({Key? key, this.role = ''}) : super(key: key);

  String? role;

  Future<bool> _retrieveToken() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'restAPI');
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      role = prefs.getString('role');
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _retrieveToken(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            if (role == 'Student') {
              return StudentHomePage();
            } else if (role == 'Teacher') {
              return TeacherHomePage();
            } else {
              return LoginScreen();
            }
          } else {
            return LoginScreen();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
