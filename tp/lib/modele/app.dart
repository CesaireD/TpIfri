import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier{
  bool isLoading = false;
  static bool isLoading1 = false;
  void changeIsLoading(){
    isLoading = !isLoading;
    isLoading1 = !isLoading1;
    notifyListeners();
  }
}