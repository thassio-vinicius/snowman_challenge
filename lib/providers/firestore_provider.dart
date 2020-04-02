import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreProvider extends ChangeNotifier {
  Firestore _database = Firestore.instance;

  Firestore get database => _database;

  void addSpot(Map<String, dynamic> spot) {
    _database.collection('spots').add(spot);

    notifyListeners();
  }

  Stream<QuerySnapshot> getStreamSpots() {
    return _database.collection('spots').snapshots();
  }

  Future<QuerySnapshot> getFutureSpots() {
    return _database.collection('spots').getDocuments();
  }

  Future<DocumentSnapshot> getSpotById(String id) {
    return _database.document('spots/$id').get();
  }

  updateSpot(
      {String id, String key, dynamic value, bool isArray = false}) async {
    if (isArray) {
      _database
          .document('spots/$id')
          .updateData({key: FieldValue.arrayUnion(value)});
    } else {
      await _database.document('spots/$id').updateData({key: value});
    }
  }

  void addUser(Map<String, dynamic> user, String email) async {
    await _database.collection('users').document(email).setData(user);

    notifyListeners();
  }

  void updateUser({Map<String, dynamic> data, var uid}) async {
    _database.document('users/$uid').updateData(data);
  }

  void removeSpot(String path) async {
    await _database.collection('spots').document(path).delete();

    notifyListeners();
  }
}
