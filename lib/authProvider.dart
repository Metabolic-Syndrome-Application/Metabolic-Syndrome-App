import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? _alias;
  String? _firstname;
  String? _lastname;
  int? _yearOfBirth;
  String? _gender;

  String? _diabetes;
  String? _hyperlipidemia;
  String? _hypertension;
  String? _obesity;

  String? get token => _token;

  String? get alias => _alias;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  int? get yearOfBirth => _yearOfBirth;
  String? get gender => _gender;

  String? get diabetes => _diabetes;
  String? get hyperlipidemia => _hyperlipidemia;
  String? get hypertension => _hypertension;
  String? get obesity => _obesity;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setProfile(String alias, String firstname, String lastname,
      int yearOfBirth, String gender) {
    _alias = alias;
    _firstname = firstname;
    _lastname = lastname;
    _yearOfBirth = yearOfBirth;
    _gender = gender;
    notifyListeners();
  }

  void setDisease(String diabetes, String hyperlipidemia, String hypertension,
      String obesity) {
    _diabetes = diabetes;
    _hyperlipidemia = hyperlipidemia;
    _hypertension = hypertension;
    _obesity = obesity;
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }
}
