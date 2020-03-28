import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.onTap,
    @required this.label,
    @required this.percentageWidth,
    this.percentageHeight = 0.08,
  });

  final VoidCallback onTap;
  final double percentageHeight;
  final double percentageWidth;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * percentageWidth,
        height: MediaQuery.of(context).size.height * percentageHeight,
        decoration: BoxDecoration(
          color: HexColor('#FFBE00'),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: CustomFonts.nunitoExtraBold,
                color: HexColor('#10159A'),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
