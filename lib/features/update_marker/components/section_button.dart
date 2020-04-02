import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class SectionButton extends StatefulWidget {
  const SectionButton({this.isFavoriteButton, this.isFavorite, this.onTap});

  final bool isFavoriteButton;
  final bool isFavorite;
  final Function onTap;

  @override
  _SectionButtonState createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(right: 24),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.isFavoriteButton
                ? HexColor('#FF7074')
                : HexColor('#10159A'),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white),
      child: Center(
        child: IconButton(
            icon: Icon(
              widget.isFavoriteButton
                  ? widget.isFavorite ? Icons.favorite : Icons.favorite_border
                  : Icons.comment,
              color: widget.isFavoriteButton
                  ? HexColor('#FF7074')
                  : HexColor('#10159A'),
              size: 24,
            ),
            onPressed: widget.onTap),
      ),
    );
  }
}
