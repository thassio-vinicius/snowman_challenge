import 'package:flutter/material.dart';

class TouristSpot {
  const TouristSpot({
    @required this.title,
    @required this.location,
    this.category,
    this.pinColor,
    this.rating,
    this.mainPicture,
    this.isFavorite,
  });

  final String title;
  final String location;
  final String mainPicture;
  final String category;
  final Color pinColor;
  final double rating;
  final bool isFavorite;

  TouristSpot copyWith({
    String title,
    String location,
    String mainPicture,
    String category,
    Color pinColor,
    double rating,
    bool isFavorite,
  }) {
    return TouristSpot(
      title: title ?? this.title,
      location: location ?? this.location,
      mainPicture: mainPicture ?? this.mainPicture,
      category: category ?? this.category,
      pinColor: pinColor ?? this.pinColor,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
