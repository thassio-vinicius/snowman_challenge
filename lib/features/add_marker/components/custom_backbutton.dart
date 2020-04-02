import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({@required this.onTap, @required this.icon});

  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0.0, 1.0),
              blurRadius: 2,
            ),
          ],
          color: Colors.white),
      margin: EdgeInsets.only(top: 24, left: 40),
      width: 40,
      height: 40,
      child: Center(
        child: IconButton(
          icon: Icon(
            icon,
            color: HexColor('#757685'),
            size: 25,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
