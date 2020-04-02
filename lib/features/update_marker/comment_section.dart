import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CommentSection extends StatelessWidget {
  const CommentSection(
      {@required this.owner, @required this.rating, @required this.comment});

  final double rating;
  final String owner;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              owner,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#757685'),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.star,
                size: 30,
                color: HexColor('#10159A'),
              ),
            ),
            Text(
              rating.toString(),
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#10159A'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          comment,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: HexColor('#757685'),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Divider(
          color: HexColor('#979797').withOpacity(0.21),
          thickness: 1,
        )
      ],
    );
  }
}
