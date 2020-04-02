import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.onTap,
    @required this.label,
    @required this.percentageWidth,
    this.margin,
    this.percentageHeight = 0.08,
  });

  final VoidCallback onTap;
  final double percentageHeight;
  final double percentageWidth;
  final String label;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * percentageWidth,
        height: MediaQuery.of(context).size.height * percentageHeight,
        margin: margin ?? EdgeInsets.zero,
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
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#10159A'),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
