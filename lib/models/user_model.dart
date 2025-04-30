import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String email;

  UserModel({required this.username, required this.email});

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
      };
  factory UserModel.fromMap(Map<dynamic, dynamic> map) => UserModel(
        username: map['username'],
        email: map['email'],
      );
}
