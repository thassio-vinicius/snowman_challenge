import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersProvider extends ChangeNotifier {
  final Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  void addNewMarker(Marker marker) {
    _markers.add(marker);

    notifyListeners();
  }

  void removeMarker(Marker marker) {
    _markers.remove(marker);

    notifyListeners();
  }
}
