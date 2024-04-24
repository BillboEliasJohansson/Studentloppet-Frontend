import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String _email; // Explicit default value to avoid null

  User([this._email = '']); // Default empty string for initial value

  String get email => _email;

  set email(String newEmail) {
    _email = newEmail;
    notifyListeners(); // Notify listeners of change
  }
}
