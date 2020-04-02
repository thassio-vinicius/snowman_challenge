import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:snowmanchallenge/models/comment.dart';

class CommentList extends Equatable {
  const CommentList({@required this.comments});

  final List<Comment> comments;

  factory CommentList.fromJson(List<dynamic> json) {
    List<Comment> comments = List<Comment>();
    comments = json.map((e) => Comment.fromJson(e)).toList();

    print('json ' + json.toString());
    print('comments ' + comments.toString());

    return CommentList(comments: comments);
  }

  Map<String, dynamic> toJson() => {'comments': comments};

  @override
  List<Object> get props => [comments];
}
