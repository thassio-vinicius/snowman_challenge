import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireStoreProvider extends ChangeNotifier {
  Firestore _database = Firestore.instance;
  Map<String, dynamic> _markers = <String, dynamic>{};

  Map<String, dynamic> get markers => _markers;
  Firestore get database => _database;

  void addSpot(Map<String, dynamic> spot) {
    _database.collection('spots').add(spot);

    notifyListeners();
  }

  void removeSpot(String path) {
    _database.collection('spots').document(path).delete();

    notifyListeners();
  }

  void addMarker(Marker marker) {
    _markers[marker.markerId.value] = marker;
    _database.collection('markers').add(markers);

    notifyListeners();
  }
}
