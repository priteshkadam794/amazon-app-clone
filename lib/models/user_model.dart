// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String address;
  final String userType;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.userType,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        userType: json["userType"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "address": address,
        "userType": userType,
        "token": token,
      };
}
