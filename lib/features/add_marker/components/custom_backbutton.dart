import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({@required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white),
      margin: EdgeInsets.only(top: 24, left: 40),
      width: 40,
      height: 40,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: HexColor('#757685'),
            size: 25,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
