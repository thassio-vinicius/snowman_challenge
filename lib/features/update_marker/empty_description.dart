import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class EmptyDescription extends StatelessWidget {
  const EmptyDescription({this.isCommentSection, this.onTap});

  final bool isCommentSection;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Text(
            isCommentSection
                ? "There's no comments yet. "
                : "There's no description yet. ",
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: HexColor('#757685'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Try adding one!',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#11159A'),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
