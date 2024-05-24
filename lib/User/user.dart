import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _email = '';
  String _password = '';
  int _age = 0;
  int _score = 0;
  String _firstName = '';
  String _lastName = '';
  String _university = '';
  String _universityDisplayName = "";
  double _weight = 0;
  String? _profilePictureUrl;
  Uint8List? _profilePictureBytes;

  bool _registered = false;
  int _startNumber = 0;
  String _clubOrCityOrCompany = "";
  int startGroup = 0;

  String get email => _email;
  int get score => _score;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get university => _university;
  double get weight => _weight;
  int get year => _age;
  String get universityDisplayName => _universityDisplayName;
  bool get registered => _registered;
  String get clubOrCityOrCompany => _clubOrCityOrCompany;
  int get startNumber => _startNumber;
  Uint8List? get profilePictureBytes => _profilePictureBytes;

  void setUser({
    String? newEmail,
    int? newScore,
    String? newFirstName,
    String? newLastName,
    String? newUniversity,
    double? newWeight,
    String? newProfilePicture,
    String? newUniversityDisplayName,
    bool? newRegistered,
    int? newStartNumber,
    String? newClubOrCityOrCompany,
    int? newStartGroup,
  }) {
    bool shouldNotify = false;

    if (newUniversityDisplayName != null) {
      _universityDisplayName = newUniversityDisplayName;
      shouldNotify = true;
    }

    if (newRegistered != null) {
      _registered = newRegistered;
      shouldNotify = true;
    }

    if (newStartNumber != null) {
      _startNumber = newStartNumber;
      shouldNotify = true;
    }

    if (newClubOrCityOrCompany != null) {
      _clubOrCityOrCompany = newClubOrCityOrCompany;
      shouldNotify = true;
    }

    if (newStartGroup != null) {
      startGroup = newStartGroup;
      shouldNotify = true;
    }

    if (newEmail != null) {
      _email = newEmail;
      shouldNotify = true;
    }

    if (newScore != null) {
      _score = newScore;
      shouldNotify = true;
    }

    if (newFirstName != null) {
      _firstName = newFirstName;
      shouldNotify = true;
    }

    if (newLastName != null) {
      _lastName = newLastName;
      shouldNotify = true;
    }

    if (newUniversity != null) {
      _university = newUniversity;
      shouldNotify = true;
    }

    if (newWeight != null) {
      _weight = newWeight;
      shouldNotify = true;
    }
    if (newProfilePicture != null) {
      _profilePictureUrl = newProfilePicture;
      _profilePictureBytes = base64Decode(newProfilePicture.split(',')[1]);
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  void updateProfilePicture(String url) {
    _profilePictureUrl = url;
    _profilePictureBytes = base64Decode(url.split(',')[1]);
    notifyListeners();
  }

  set email(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set password(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set age(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set firstName(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set lastname(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set university(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  set profilePictureBytes(Uint8List? newProfilepicture) {
    _profilePictureBytes = newProfilepicture;
    notifyListeners(); // Notify listeners of change
  }

  void reset() {
    _email = ''; // Reset to empty string
    _score = 0; // Reset to 0
    _firstName = ''; // Reset to empty string
    _lastName = ''; // Reset to empty string
    _university = ''; // Reset to empty string
    _weight = 0;
    _profilePictureUrl = null;
    _profilePictureBytes = null;
    _registered = false; // Reset to false
    _startNumber = 0; // Reset to 0
    _clubOrCityOrCompany = ''; // Reset to empty string
    startGroup = 0; // Reset to

    notifyListeners(); // Notify listeners that the state has changed
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
      'password': _password,
      'age': _age,
      'firstName': _firstName,
      'lastName': _lastName,
      'university': _university,
      'score': _score,
      'profilePictureUrl': _profilePictureUrl,
    };
  }
}
