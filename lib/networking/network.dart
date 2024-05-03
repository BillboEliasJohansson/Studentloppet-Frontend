import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:studentloppet/Screens/app_screens/home_screen.dart'; // for JSON parsing

class network {
  static Future<http.Response> callSignUp(
      String university, String email, String password) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/studentloppet/addwithuni/' +
            email +
            "/" +
            password +
            "/" +
            university));
    return response;
  }

  static Future<http.Response> callLogIn(String email, String password) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/studentloppet/login/' +
            email +
            "/" +
            password));

    return response;
  }

  static Future<http.Response> callOtp(String email) async {
    final response = await http.post(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/forgotPassword/verifyEmail/' +
            email));
    return response;
  }

  static Future<http.Response> sendOtp(String otp, String email) async {
    final response = await http.post(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/forgotPassword/verifyOtp/" +
            otp +
            "/" +
            email));
    return response;
  }

  static Future<http.Response> updatePassword(
      Map<String, String> passwordData, String email) async {
    String url =
        'https://group-15-2.pvt.dsv.su.se/forgotPassword/changePassword/' +
            email;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(passwordData),
    );

    return response;
  }

  static Future<http.Response> postActivity(
      String email, double distance, Duration duration) async {
    String url =
        "https://group-15-2.pvt.dsv.su.se/api/activities/addActivity/" +
            email +
            "/" +
            (distance / 1000).toString() +
            "/" +
            duration.inMinutes.toString();

    final response = await http.post(Uri.parse(url));

    print(response.body);

    return response;
  }

  static Future<http.Response> updateName(
      String email, String first, String last) async {
    final response = await http.get(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/studentloppet/set/" +
            email +
            "/" +
            first +
            "/" +
            last));
    return response;
  }

  static Future<List<DropdownMenuEntry<String>>> requestUniverityList() async {
    final response = await http.get(
      Uri.parse(
          'https://group-15-2.pvt.dsv.su.se/api/universities/representation'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      Map<String, dynamic> universities =
          json.decode(utf8.decode(response.bodyBytes));

      // Convert the map to a list of DropdownMenuEntry<String>
      List<DropdownMenuEntry<String>> entries = universities.entries
          .map((entry) =>
              DropdownMenuEntry<String>(value: entry.key, label: entry.value))
          .toList();

      return entries;
    } else {
      // Handle the case when the server isn't returning a 200 OK response
      throw Exception('Failed to load university list');
    }
  }

  static Future<List<University>> getLeaderboard() async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/universities/scoreboard'));

    if (response.statusCode == 200) {
      // Check if the request was successful
      List<dynamic> data = jsonDecode(response.body); // Decode JSON

      List<University> universities = data.map((item) {
        return University.fromJson(item);
      }).toList(); // Convert each item to a University object

      return universities; // Return the list of universities
    } else {
      throw Exception("Failed to load leaderboard"); // Handle failure cases
    }
  }
}
