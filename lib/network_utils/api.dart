import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_flutter_app_dl/models/content.dart';
import 'package:my_flutter_app_dl/models/content_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseURL = "http://10.0.2.2:8000/api/";
//const String baseURL = "http://127.0.0.1:8000/api/";
const Map<String, String> headers = {"Content-Type": "application/json"};

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String mobile, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
    };

    final body = json.encode(data);
    final url = Uri.parse('${baseURL}teacher/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);
    return response;
  }

  static Future<int> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };

    final body = json.encode(data);
    final url = Uri.parse('${baseURL}teacher/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (jsonResponse != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonResponse['token']);
      //print(prefs.getString('token'));
    }

    return response.statusCode;
  }
}

class DashboardServices {
  static Future<List<Contents>> teacherDashboard() async {
    try {
      final url = Uri.parse('${baseURL}teacher/dashboard');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');

      http.Response response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // If successful, parse the response data and return a list of Contents
        final jsonData = json.decode(response.body);
        List<Contents> contentsList = List<Contents>.from(
            jsonData['content'].map((data) => Contents.fromJson(data)));

        return contentsList;
      } else {
        // If there was an error, throw an exception with the status code
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }

    // if (response.statusCode == 200) {
    //   final jsonData = json.decode(response.body);
    //   // print(jsonData);
    //   List<dynamic> listContents = jsonData['content'];
    //   print(listContents);
    //   List<Contents> contentsList =
    //       listContents.map((item) => Contents.fromJson(item)).toList();
    //   print(contentsList.map((content) => content.cntTitle).toList());

    //   return contentsList;
    // } else {
    //   throw Exception('Fail to load contents');
    // }
  }
}

class ContentDetailsService {
  static Future<ContentDetails> getContentDetails(int contentId) async {
    try {
      print(contentId);
      final url = Uri.parse('${baseURL}teacher/content/$contentId');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');

      http.Response response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // If successful, parse the response data and return the ContentDetails object
        final jsonData = json.decode(response.body);

        ContentDetails contentDetails =
            ContentDetails.fromJson(jsonData['contentDetail']);

        return contentDetails;
      } else {
        // If there was an error, throw an exception with the status code
        throw Exception(
            'Failed to load content details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
