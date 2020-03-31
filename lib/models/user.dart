import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  const User(
      {@required this.displayName,
      @required this.email,
      @required this.urlPhoto,
      @required this.id});

  final String id;
  final String displayName;
  final String email;
  final String urlPhoto;

  User copyWith({
    String id,
    String displayName,
    String email,
    String urlPhoto,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      urlPhoto: urlPhoto ?? this.urlPhoto,
    );
  }

  factory User.fromJson({Map<String, dynamic> json}) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      urlPhoto: json['urlPhoto'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'displayName': this.displayName,
        'email': this.email,
        'urlPhoto': this.urlPhoto,
      };

  @override
  List<Object> get props => [displayName, email, urlPhoto, id];
}
