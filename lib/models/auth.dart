import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/utils/constants.dart';

class Auth with ChangeNotifier {
  Future<void> signup(String email, String password) async {
    final response = await post(
      Uri.parse(Constants.signupURL),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    print(response.body);
  }
}
