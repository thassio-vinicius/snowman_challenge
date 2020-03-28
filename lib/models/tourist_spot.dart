import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snowmanchallenge/models/comment.dart';

class TouristSpot {
  const TouristSpot({
    @required this.title,
    @required this.location,
    this.associatedMarker,
    this.description,
    this.comments,
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
  final String description;
  final List<Comment> comments;
  final Marker associatedMarker;
  final Color pinColor;
  final double rating;
  final bool isFavorite;

  TouristSpot copyWith({
    String title,
    String location,
    String mainPicture,
    String category,
    String description,
    Marker associatedMarker,
    List<Comment> comments,
    Color pinColor,
    double rating,
    bool isFavorite,
  }) {
    return TouristSpot(
      title: title ?? this.title,
      location: location ?? this.location,
      mainPicture: mainPicture ?? this.mainPicture,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      associatedMarker: associatedMarker ?? this.associatedMarker,
      category: category ?? this.category,
      pinColor: pinColor ?? this.pinColor,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    List<Comment> commentList = [];

    if (json['comments'] != null) {
      var list = json['comments'] as List;
      commentList = list.map((e) => Comment.fromJson(e)).toList();
    }

    return TouristSpot(
      title: json['title'],
      location: json['location'],
      associatedMarker: json['associatedMarker'],
      comments: commentList,
      category: json['category'],
      pinColor: json['pinColor'],
      rating: json['rating'],
      mainPicture: json['mainPicture'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'location': this.location,
        'category': this.category,
        'associatedMarker': this.associatedMarker,
        'comments': this.comments,
        'description': this.description,
        'pinColor': this.pinColor,
        'rating': this.rating,
        'mainPicture': this.mainPicture,
        'isFavorite': this.isFavorite,
      };
}
