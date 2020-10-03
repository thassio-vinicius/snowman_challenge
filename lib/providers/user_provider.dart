import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/models/firestore_user.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  FirestoreUser _firestoreUser;

  FirestoreUser get firestoreUser => _firestoreUser;

  User get user => _user;

  saveUserInfo(User user) {
    _user = user;

    notifyListeners();
  }

  deleteFirebaseUser() {
    _user = null;

    notifyListeners();
  }

  saveFirestoreUser(FirestoreUser user) {
    _firestoreUser = user;

    notifyListeners();
  }
}
