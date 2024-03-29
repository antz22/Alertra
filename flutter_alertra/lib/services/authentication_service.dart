import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_produce_provider/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  static const API_BASE_URL = 'http://10.0.2.2:5000';
  // static const API_BASE_URL = 'http://192.168.1.126:5000';

  Future<Map> registerUser(username, password, role, school) async {
    var headers = {"Content-Type": "application/json"};
    var url = Uri.parse(API_BASE_URL + '/api/v1/users/');
    var body = json.encode({
      'username': username,
      'password': password,
    });
    var response = await http.post(url, headers: headers, body: body);

    Map data = {
      'statusCode': response.statusCode.toString(),
      'body': json.decode(response.body),
    };

    headers = {"Content-Type": "application/json"};
    url = Uri.parse(API_BASE_URL + '/api/v1/token/login/');
    body = json.encode({
      'username': username,
      'password': password,
    });

    response = await http.post(url, headers: headers, body: body);
    Map<String, dynamic> tokenData = json.decode(response.body);

    if (response.statusCode == 200) {
      String token = tokenData['auth_token'];
      var storage = const FlutterSecureStorage();
      await storage.write(key: 'restAPI', value: token);

      headers = {
        "Content-Type": "application/json",
        "Authorization": "Token " + token
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', role);
      prefs.setString('school', school);

      body = json.encode({
        'role': role,
        'school': school,
      });

      url = Uri.parse(API_BASE_URL + '/api/v1/create-user/');
      response = await http.post(url, headers: headers, body: body);
    }

    return data;
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    var headers = {"Content-Type": "application/json"};
    var url = Uri.parse(API_BASE_URL + '/api/v1/token/login/');
    final body = json.encode({
      'username': username,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);
    Map<String, dynamic> tokenData = json.decode(response.body);

    if (response.statusCode == 200) {
      String token = tokenData['auth_token'];
      var storage = const FlutterSecureStorage();
      await storage.write(key: 'restAPI', value: token);

      headers = {
        "Content-Type": "application/json",
        "Authorization": "Token " + token
      };
      url = Uri.parse(API_BASE_URL + '/api/v1/get-user-data/');
      response = await http.get(url, headers: headers);
      Map data = json.decode(response.body);
      String role = data['role'];
      String school = data['school'];
      String name = data['username'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', role);
      prefs.setString('school', school);
      prefs.setString('username', name);
    }
    Map<String, dynamic> responseData = {
      'statusCode': response.statusCode.toString(),
      'body': json.decode(response.body),
    };
    return responseData;
  }

  Future<Map<String, dynamic>> sawoSignIn(
      String username, String password) async {
    final headers = {"Content-Type": "application/json"};
    final url = Uri.parse(API_BASE_URL + '/api/v1/token/login/');
    final body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);
    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      String token = data['auth_token'];
      var storage = const FlutterSecureStorage();
      await storage.write(key: 'restAPI', value: token);
    }
    Map<String, dynamic> responseData = {
      'statusCode': response.statusCode.toString(),
      'body': json.decode(response.body),
    };
    return responseData;
  }

  Future<String> signOut() async {
    var storage = const FlutterSecureStorage();
    await storage.deleteAll();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    return 'Signed Out';
  }
}
