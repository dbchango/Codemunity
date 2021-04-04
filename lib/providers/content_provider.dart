import 'package:code_munnity/models/author.dart';
import 'package:flutter/material.dart';

class ContentProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _darkMode = false;
  String _token = "";
  String _author = "";

  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int value) {
    this._selectedIndex = value;
    notifyListeners();
  }

  bool get darkMode {
    return this._darkMode;
  }

  set darkMode(bool value) {
    this._darkMode = value;
    notifyListeners();
  }

  initDarkMode(bool value) {
    this._darkMode = value;
  }

  String get token {
    return this._token;
  }

  set token(String value) {
    this._token = value;
    notifyListeners();
  }

  String get author{
    return this._author;
  }

  set author(String authorString){
    this._author = authorString;
    notifyListeners();
  }
}
