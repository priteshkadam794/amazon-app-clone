import 'dart:convert';

import 'package:e_commerce_app/constants/error_handeling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign-up the user
  void signUpUser({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
          id: "",
          username: username,
          email: email,
          password: password,
          address: "",
          userType: "",
          token: "");
      http.Response httpResponse = await http.post(
        Uri.parse("$uri/auth/signup"),
        body: userToJson(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      handleHttpResonse(
          context: context,
          onSuccess: () {
            showSnackBar(context, jsonDecode(httpResponse.body)['msg']);
          },
          httpResponse: httpResponse);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  // sign-in user

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: "",
          username: "",
          email: email,
          password: password,
          address: "",
          userType: "",
          token: "");

      http.Response response = await http.post(Uri.parse("$uri/auth/signin"),
          body: userToJson(user),
          headers: <String, String>{
            'Content-Type': 'application/json;  charset=UTF-8',
          });

      // ignore: use_build_context_synchronously
      handleHttpResonse(
          context: context,
          onSuccess: () async {
            // Obtain shared preferences.
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonDecode(response.body));
            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
          },
          httpResponse: response);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  //validate token and get userData
  void validateUserAndGetUserData({
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString('x-auth-token', "");
        token = "";
      }

      http.Response tokenRes = await http
          .get(Uri.parse("$uri/auth/getUserData"), headers: <String, String>{
        'Content-Type': 'application/json;  charset=UTF-8',
        'x-auth-token': token,
      });

      if (tokenRes.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setUser(jsonDecode(tokenRes.body));
      }
    } catch (e) {
      return;
    }
  }
}
