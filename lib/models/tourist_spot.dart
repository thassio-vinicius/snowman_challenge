import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/models/comment.dart';

class TouristSpot extends Equatable {
  const TouristSpot({
    @required this.title,
    @required this.location,
    this.associatedMarkerId,
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
  final String associatedMarkerId;
  final String pinColor;
  final double rating;
  final bool isFavorite;

  TouristSpot copyWith({
    String title,
    String location,
    String mainPicture,
    String category,
    String description,
    String associatedMarkerId,
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
      associatedMarkerId: associatedMarkerId ?? this.associatedMarkerId,
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
      associatedMarkerId: json['associatedMarkerId'],
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
        'associatedMarkerId': this.associatedMarkerId,
        'comments': this.comments,
        'description': this.description,
        'pinColor': this.pinColor,
        'rating': this.rating,
        'mainPicture': this.mainPicture,
        'isFavorite': this.isFavorite,
      };

  @override
  List<Object> get props => [
        title,
        location,
        mainPicture,
        category,
        description,
        comments,
        associatedMarkerId,
        pinColor,
        rating,
        isFavorite,
      ];
}
