import 'package:flutter/material.dart';

class Comment {
  const Comment({@required this.comment, @required this.rating});

  final String comment;
  final double rating;

  Comment copyWith({String comment, double rating}) => Comment(
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
      );

  Comment.fromJson(Map<String, dynamic> json)
      : comment = json['comment'],
        rating = json['rating'];

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'rating': rating,
      };
}
