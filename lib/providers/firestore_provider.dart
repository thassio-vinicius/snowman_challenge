import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreProvider extends ChangeNotifier {
  FirebaseFirestore _database = FirebaseFirestore.instance;

  FirebaseFirestore get database => _database;

  void addSpot(Map<String, dynamic> spot) {
    _database.collection('spots').add(spot);

    notifyListeners();
  }

  Stream<QuerySnapshot> getStreamSpots() {
    return _database.collection('spots').snapshots();
  }

  Future<QuerySnapshot> getFutureSpots() {
    return _database.collection('spots').get();
  }

  Future<DocumentSnapshot> getSpotById(String id) {
    return _database.doc('spots/$id').get();
  }

  updateSpot(
      {String id, String key, dynamic value, bool isArray = false}) async {
    if (isArray) {
      _database.doc('spots/$id').update({key: FieldValue.arrayUnion(value)});
    } else {
      await _database.doc('spots/$id').update({key: value});
    }
  }

  void addUser(Map<String, dynamic> user, String email) async {
    await _database.collection('users').doc(email).set(user);

    notifyListeners();
  }

  void updateUser({Map<String, dynamic> data, var uid}) async {
    _database.doc('users/$uid').update(data);
  }

  void removeSpot(String path) async {
    await _database.collection('spots').doc(path).delete();

    notifyListeners();
  }
}
