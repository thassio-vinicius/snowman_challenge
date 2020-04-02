import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/models/comment.dart';

class TouristSpot extends Equatable {
  const TouristSpot({
    @required this.title,
    @required this.location,
    @required this.owner,
    @required this.id,
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
  final String owner;
  final String mainPicture;
  final String category;
  final String description;
  final List<Comment> comments;
  final String id;
  final String pinColor;
  final double rating;
  final bool isFavorite;

  TouristSpot copyWith({
    String title,
    String location,
    String mainPicture,
    String owner,
    String category,
    String description,
    String id,
    List<Comment> comments,
    Color pinColor,
    double rating,
    bool isFavorite,
  }) {
    return TouristSpot(
      title: title ?? this.title,
      location: location ?? this.location,
      owner: owner ?? this.owner,
      mainPicture: mainPicture ?? this.mainPicture,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      id: id ?? this.id,
      category: category ?? this.category,
      pinColor: pinColor ?? this.pinColor,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];

    if (json['comments'] != null) {
      var list = List.from(json['comments']);
      list.map((e) => comments.add(Comment.fromJson(e)));
    }

    return TouristSpot(
      title: json['title'],
      location: json['location'],
      owner: json['owner'],
      description: json['description'],
      id: json['id'],
      comments: comments,
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
        'owner': this.owner,
        'id': this.id,
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
        owner,
        description,
        comments,
        id,
        pinColor,
        rating,
        isFavorite,
      ];
}
