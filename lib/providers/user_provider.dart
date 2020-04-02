import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/models/user.dart';

class UserProvider extends ChangeNotifier {
  FirebaseUser _user;

  User _customUser;

  User get customUser => _customUser;

  FirebaseUser get user => _user;

  saveUserInfo(FirebaseUser user) {
    _user = user;

    notifyListeners();
  }

  deleteFirebaseUser() {
    _user = null;

    notifyListeners();
  }

  saveCustomUser(User user) {
    _customUser = user;

    notifyListeners();
  }
}
