import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _email = '';
  int _score = 0;
  String _firstName = '';
  String _lastName = '';
  String _university = '';
  int _weight = 0;

  String get email => _email;
  int get score => _score;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get university => _university;
  int get weight => _weight;

  void setUser({
    String? newEmail,
    int? newScore,
    String? newFirstName,
    String? newLastName,
    String? newUniversity,
    int? newWeight,
  }) {
    bool shouldNotify = false;

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

    if (shouldNotify) {
      notifyListeners();
    }
  }

  set email(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }

  void reset() {
    _email = ''; // Reset to empty string
    _score = 0; // Reset to 0
    _firstName = ''; // Reset to empty string
    _lastName = ''; // Reset to empty string
    _university = ''; // Reset to empty string
    _weight = 0;

    notifyListeners(); // Notify listeners that the state has changed
  }
}
