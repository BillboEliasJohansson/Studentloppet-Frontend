import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert'; // for JSON parsing

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

  static Future<http.Response> sendOtp(String otp , String email) async {
    final response = await http.post(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/forgotPassword/verifyOtp/" + otp + "/" + email));
    return response;
  }

  //TODO RECORD 
  static Future<http.Response> updatePassword(String password , String email) async {
    final response = await http.get(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/forgotPassword/verifyOtp/" + password + "/" + email));
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
}
