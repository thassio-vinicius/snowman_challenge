import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireStoreProvider extends ChangeNotifier {
  Firestore _database = Firestore.instance;

  Firestore get database => _database;

  void addSpot(Map<String, dynamic> spot) {
    _database.collection('spots').add(spot);

    notifyListeners();
  }

  void addUser(Map<String, dynamic> user) {
    _database.collection('users').add(user);

    notifyListeners();
  }

  void removeSpot(String path) {
    _database.collection('spots').document(path).delete();

    notifyListeners();
  }

  void addMarker(Marker marker) async {
    _database.collection('markers').add({
      'markerId': marker.markerId.value,
      'position': [marker.position.latitude, marker.position.longitude],
    });

    notifyListeners();
  }
}
