import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirestoreProvider extends ChangeNotifier {
  Firestore _database = Firestore.instance;
  /*
  Future<List<Map<String, dynamic>>> _markers =
      Firestore.instance.collection('markers').getDocuments().then((docs) {
    var map = docs.documents;
    List<Map<String, dynamic>> retrievedMap;
    if (map.isNotEmpty) {
      print('map docs: ' + map.toString());
      for (int i = 0; i < docs.documents.length; i++) {
        retrievedMap.add(map[i].data);
        print('map for:' + map[i].data.toString());
        print('retrieved map:' + retrievedMap.toString());
      }
    } else {
      print('map is empty?');
    }
    return retrievedMap;
  });

   */

  //Future<List<Map<String, dynamic>>> get markers async => await _markers;

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
    //markers[marker.markerId.value] = marker;

    //var markers = await _markers;

    /*
    markers.add({
      'markerId': marker.markerId.value,
      //'icon': jsonEncode(marker.icon),
      //'onTap': jsonEncode(marker.onTap),
      'position': [marker.position.latitude, marker.position.longitude],
    });

     */

    _database.collection('markers').add({
      'markerId': marker.markerId.value,
      //'icon': jsonEncode(marker.icon),
      //'onTap': jsonEncode(marker.onTap),
      'position': [marker.position.latitude, marker.position.longitude],
    });

    notifyListeners();
  }
}
