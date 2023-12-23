import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      username: "",
      email: "",
      password: "",
      address: "",
      userType: "",
      token: "");
  User get user => _user;

  void setUser(user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
