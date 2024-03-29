import 'dart:convert';

import 'package:flutter_alertra/models/alert.dart';
import 'package:flutter_alertra/models/report.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static const API_BASE_URL = 'http://10.0.2.2:5000';
  // static const API_BASE_URL = 'http://192.168.1.126:5000';

  Future<List<dynamic>?> retrieveAlerts() async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/get-alerts/');
    final response = await http.get(url, headers: headers);
    List<dynamic> data = json.decode(response.body);
    List<Alert> alerts = data.map((alert) => Alert.fromJson(alert)).toList();
    return alerts;
  }

  Future<List<dynamic>?> retrieveReports() async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/get-reports/');
    final response = await http.get(url, headers: headers);
    List<dynamic> data = json.decode(response.body);
    List<Report> reports =
        data.map((report) => Report.fromJson(report)).toList();
    return reports;
  }

  Future<Report> retrieveReport(int id) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/get-report-data/');
    final body = json.encode({
      'report_id': id,
    });
    final response = await http.post(url, headers: headers, body: body);
    var data = json.decode(response.body);
    Report report = Report.fromJson(data);
    return report;
  }

  Future<Map<String, dynamic>> retrieveSchoolInfo() async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/get-school-data/');
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body);
    return data;
  }

  Future<String> createReport(
      String priority,
      String description,
      String altitude,
      String floor,
      String latitude,
      String longitude,
      String address,
      String reportType,
      String? filename,
      bool isEmergency) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    if (isEmergency) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token " + token!
      };
      final url = Uri.parse(API_BASE_URL + '/api/v1/create-report/');
      final body = json.encode({
        'priority': priority,
        'description': description,
        'altitude': altitude,
        'floor': floor,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'report_type': reportType,
      });
      try {
        await http.post(url, headers: headers, body: body);
        return 'Success';
      } catch (e) {
        return e.toString();
      }
    } else {
      var request = http.MultipartRequest(
          'POST', Uri.parse(API_BASE_URL + '/api/v1/create-report/'));
      request.headers['Authorization'] = "Token " + token!;
      request.headers['Content-Type'] = "application/json";
      request.fields['priority'] = priority;
      request.fields['description'] = description;
      request.fields['altitude'] = altitude;
      request.fields['floor'] = floor;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['address'] = address;
      request.fields['report_type'] = reportType;
      if (filename != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            filename,
          ),
        );
      }
      var result = await request.send();
      return result.reasonPhrase!;
    }
  }

  Future<String> createAlert(
    String recipients,
    String headline,
    String content,
    String priority,
    String alertType,
    Report? report,
  ) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/create-alert/');
    final body = report != null
        ? json.encode({
            'recipient': recipients,
            'headline': headline,
            'content': content,
            'alert_type': alertType,
            'priority': priority,
            'report_id': report.id,
          })
        : json.encode({
            'recipient': recipients,
            'headline': headline,
            'content': content,
            'alert_type': alertType,
            'priority': priority,
          });
    try {
      await http.post(url, headers: headers, body: body);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createSchool(
      String name, String address, String city, String state) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/create-school/');
    final body = json.encode({
      'name': name,
      'address': address,
      'city': city,
      'state': state,
    });
    try {
      await http.post(url, headers: headers, body: body);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteReport(int id) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/delete-report/');
    final body = json.encode({
      'id': id,
    });
    try {
      await http.put(url, headers: headers, body: body);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> approveReport(int id, bool approved) async {
    var storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'restAPI');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
    final url = Uri.parse(API_BASE_URL + '/api/v1/approve-report/');
    final body = json.encode({
      'id': id,
      'approved': approved,
    });
    try {
      await http.put(url, headers: headers, body: body);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
