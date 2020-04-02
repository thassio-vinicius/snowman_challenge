import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreProvider extends ChangeNotifier {
  Firestore _database = Firestore.instance;

  Firestore get database => _database;

  void addSpot(Map<String, dynamic> spot) {
    _database.collection('spots').add(spot);

    notifyListeners();
  }

  Future<DocumentSnapshot> getSpotById(String id) {
    return _database.document('spots/$id').get();
  }

  updateSpot({String id, String key, dynamic value, int index}) async {
    await _database.document('spots/$id').updateData({key[index]: value});
  }

  void addUser(Map<String, dynamic> user) {
    _database.collection('users').add(user);

    notifyListeners();
  }

  void removeSpot(String path) {
    _database.collection('spots').document(path).delete();

    notifyListeners();
  }
}
