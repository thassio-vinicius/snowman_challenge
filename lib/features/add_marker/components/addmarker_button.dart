import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class NewMarkerButton extends StatelessWidget {
  const NewMarkerButton({@required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.08,
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
              'Add Spot',
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
