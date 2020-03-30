import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Comment extends Equatable {
  const Comment({@required this.comment, @required this.rating});

  final String comment;
  final double rating;

  Comment copyWith({String comment, double rating}) => Comment(
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
      );

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'rating': rating,
      };

  @override
  List<Object> get props => [comment, rating];
}
