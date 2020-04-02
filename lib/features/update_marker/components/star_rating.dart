import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount = 5;
  final double rating;
  final double size;
  final RatingChangeCallback onRatingChanged;
  final Color color = HexColor('#11159A');

  StarRating({this.onRatingChanged, this.rating = .0, this.size = 30});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        size: size,
        color: color,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        size: size,
        color: color,
      );
    } else {
      icon = new Icon(
        Icons.star,
        size: size,
        color: color,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
