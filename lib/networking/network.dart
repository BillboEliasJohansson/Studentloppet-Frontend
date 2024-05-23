
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';
import 'package:studentloppet/Screens/app_screens/home_screen.dart'; // for JSON parsing

class network {
  static Future<http.Response> callSignUp(
      String university, String email, String password) async {
    final response = await http.post(Uri.parse(
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

  static Future<Map<String, dynamic>> postActivity(
      String email, double distance, Duration duration) async {
    String url =
        "https://group-15-2.pvt.dsv.su.se/api/activities/addActivity/" +
            email +
            "/" +
            (distance / 1000).toString() +
            "/" +
            duration.inSeconds.toString();

    final response = await http.post(Uri.parse(url));

    Map<String, dynamic> data = jsonDecode(response.body);

    return data;
  }

  static Future<http.Response> updateName(
      String email, String first, String last) async {
    final response = await http.post(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/studentloppet/set/" +
            email +
            "/" +
            first +
            "/" +
            last));
    print(response.body);
    return response;
  }

  static Future<http.Response> setWeight(String email, String weight) async {
    final response = await http.get(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/studentloppet/setWeight/" +
            email +
            "/" +
            weight));
    return response;
  }

  static Future<http.Response> setYear(String email, String year) async {
    final response = await http.post(Uri.parse(
        "https://group-15-2.pvt.dsv.su.se/studentloppet/setYearOfBirth/" +
            email +
            "/" +
            year));
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
        return University.scoreFromJson(item);
      }).toList(); // Convert each item to a University object

      return universities; // Return the list of universities
    } else {
      throw Exception("Failed to load leaderboard"); // Handle failure cases
    }
  }

  static Future<List<University>> getLeaderboardDistance() async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/universities/universitiesByDistance'));

    if (response.statusCode == 200) {
      // Check if the request was successful
      List<dynamic> data = jsonDecode(response.body); // Decode JSON

      List<University> universities = data.map((item) {
        return University.distanceFromJson(item);
      }).toList(); // Convert each item to a University object

      return universities; // Return the list of universities
    } else {
      throw Exception("Failed to load leaderboard"); // Handle failure cases
    }
  }

  static Future<List<University>> getLeaderboardUsercount() async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/universities/universitiesByUserCount'));

    if (response.statusCode == 200) {
      // Check if the request was successful
      List<dynamic> data = jsonDecode(response.body); // Decode JSON

      List<University> universities = data.map((item) {
        return University.usercountFromJson(item);
      }).toList(); // Convert each item to a University object

      return universities; // Return the list of universities
    } else {
      throw Exception("Failed to load leaderboard"); // Handle failure cases
    }
  }

  static Future<Map<String, int>> getUniLeaderboardScore(String uni) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/leaderboard/sortedByScore/' +
            uni));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, int> topFiveUsers = {};

      for (int i = 0; i < data.length; i++) {
        var user = data[i];
        String userName = user['userName'];
        int score = user['score'];

        // Check if the user name already exists in the map
        if (topFiveUsers.containsKey(userName)) {
          // Append a unique identifier to the user name
          int counter = 1;
          String uniqueUserName = userName + '_$counter';
          while (topFiveUsers.containsKey(uniqueUserName)) {
            counter++;
            uniqueUserName = userName + '_$counter';
          }
          userName = uniqueUserName;
        }

        // Add the user name and score to the map
        topFiveUsers[userName] = score;
      }
      return topFiveUsers;
    } else {
      throw Exception("Failed to load leaderboard");
    }
  }

  static Future<Map<String, double>> getUniLeaderboardDistance(
      String uni) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/leaderboard/sortedByDistance/' +
            uni));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, double> topFiveUsers = {};

      for (int i = 0; i < data.length; i++) {
        var user = data[i];
        print(data);
        String userName = user['fullName'];
        double score = user['value'];

        // Check if the user name already exists in the map
        if (topFiveUsers.containsKey(userName)) {
          // Append a unique identifier to the user name
          int counter = 1;
          String uniqueUserName = userName + '_$counter';
          while (topFiveUsers.containsKey(uniqueUserName)) {
            counter++;
            uniqueUserName = userName + '_$counter';
          }
          userName = uniqueUserName;
        }

        // Add the user name and score to the map
        topFiveUsers[userName] = score;
      }
      return topFiveUsers;
    } else {
      throw Exception("Failed to load leaderboard");
    }
  }

  static Future<Map<String, double>> getUniLeaderboardSpeed(String uni) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/leaderboard/sortedBySpeed/' +
            uni));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, double> topFiveUsers = {};

      for (int i = 0; i < data.length; i++) {
        var user = data[i];
        String userName = user['fullName'];
        double score = user['value'];

        // Check if the user name already exists in the map
        if (topFiveUsers.containsKey(userName)) {
          // Append a unique identifier to the user name
          int counter = 1;
          String uniqueUserName = userName + '_$counter';
          while (topFiveUsers.containsKey(uniqueUserName)) {
            counter++;
            uniqueUserName = userName + '_$counter';
          }
          userName = uniqueUserName;
        }

        // Add the user name and score to the map
        topFiveUsers[userName] = score;
      }
      return topFiveUsers;
    } else {
      throw Exception("Failed to load leaderboard");
    }
  }

  static Future<Map<String, dynamic>> getTotalActivity(String email) async {
    final response = await http.get(
      Uri.parse(
          'https://group-15-2.pvt.dsv.su.se/api/activities/total/' + email),
    );

    if (response.statusCode == 200) {
      // Dekodera JSON
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.toString());
      // Returnera kartan
      return data;
    } else {
      // Hantera fel
      throw Exception("Failed to load activity data");
    }
  }

  static Future<Map<String, dynamic>> getWeeklyActivity(String email) async {
    final response = await http.get(
      Uri.parse(
          'https://group-15-2.pvt.dsv.su.se/api/activities/totalWeekSummary/' +
              email),
    );

    if (response.statusCode == 200) {
      // Dekodera JSON
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.toString());
      // Returnera kartan
      return data;
    } else {
      // Hantera fel
      throw Exception("Failed to load activity data");
    }
  }

  static Future<Map<String, dynamic>> getUniRank(String email) async {
    final response = await http.get(
      Uri.parse(
          'https://group-15-2.pvt.dsv.su.se/studentloppet/userRank/' + email),
    );

    if (response.statusCode == 200) {
      // Dekodera JSON
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.toString());
      // Returnera kartan
      return data;
    } else {
      // Hantera fel
      throw Exception("Failed to load activity data");
    }
  }

  static Future<http.Response> uploadProfilePicture(
      String email, CroppedFile image) async {
    var request = http.MultipartRequest(
      'put',
      Uri.parse('https://group-15-2.pvt.dsv.su.se/api/profile-pictures/update'),
    );
    request.fields['email'] = email;
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      return http.Response('Profile picture uploaded successfully', 200);
    } else {
      return http.Response(
          'Error uploading profile picture', response.statusCode);
    }
  }

  static Future<http.Response> getProfilePicture(String email) async {
    final response = await http.get(Uri.parse(
        'https://group-15-2.pvt.dsv.su.se/api/profile-pictures/by-email/$email'));

    return response;
  }
}
