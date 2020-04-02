import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(
        HexColor('#10159A'),
      ),
    );
  }
}
