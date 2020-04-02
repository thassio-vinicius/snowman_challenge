import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  const User(
      {@required this.displayName,
      @required this.email,
      @required this.photoUrl,
      @required this.uid});

  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  User copyWith({
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) {
    return User(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory User.fromJson({Map<String, dynamic> json}) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'displayName': this.displayName,
        'email': this.email,
        'photoUrl': this.photoUrl,
      };

  @override
  List<Object> get props => [displayName, email, photoUrl, uid];
}
