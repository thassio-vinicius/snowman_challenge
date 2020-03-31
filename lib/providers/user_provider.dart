import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  FirebaseUser _user;

  FirebaseUser get user => _user;

  saveUserInfo(FirebaseUser user) {
    _user = user;
  }

  loadUserInfo() {
    _user.reload();
  }
}
