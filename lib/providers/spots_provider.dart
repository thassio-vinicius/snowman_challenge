import 'package:flutter/cupertino.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';

class SpotsProvider extends ChangeNotifier {
  final List<TouristSpot> _spots = [];

  List<TouristSpot> get spots => _spots;

  void addSpot(TouristSpot spot) {
    _spots.add(spot);

    notifyListeners();
  }

  void removeSpot(TouristSpot spot) {
    _spots.remove(spot);

    notifyListeners();
  }
}
