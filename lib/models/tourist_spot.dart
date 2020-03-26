import 'package:flutter/material.dart';

class TouristSpot {
  const TouristSpot({
    @required this.title,
    @required this.location,
    this.rating,
    this.mainPicture,
    this.isFavorite,
  });

  final String title;
  final String location;
  final String mainPicture;
  final double rating;
  final bool isFavorite;

  TouristSpot copyWith({
    String title,
    String location,
    String mainPicture,
    double rating,
    bool isFavorite,
  }) {
    return TouristSpot(
      title: title ?? this.title,
      location: location ?? this.location,
      mainPicture: mainPicture ?? this.mainPicture,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
