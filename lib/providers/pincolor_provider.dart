import 'package:flutter/cupertino.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class PinColorProvider extends ChangeNotifier {
  Color _color = HexColor('#10159A');

  Color get currentColor => _color;

  void newColor(Color color) {
    _color = color;

    notifyListeners();
  }

  getHexColorCurrentValue() {
    return _color.toString().toUpperCase().substring(8).replaceAll(')', '');
  }
}
