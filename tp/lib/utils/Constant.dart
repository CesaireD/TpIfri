import 'package:flutter/material.dart';

class Constant {
  static final USERNAME_PREF_KEY = "";
  static final USER_ID_PREF_KEY = "";
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if(text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red,);
    messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
}