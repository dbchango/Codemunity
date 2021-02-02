import 'dart:convert';

import 'package:code_munnity/models/author.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static final Preferences _instance = new Preferences._internal();

  factory Preferences(){
    return _instance;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  init() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  get mode{
    return _prefs.getBool('mode') ?? true;
  }

  set mode(bool value){
    _prefs.setBool('mode', value);
  }

  get main{
    return _prefs.getInt("main") ?? 1;
  }

  set main(int value){
    _prefs.setInt("main", value);
  }

  get  gauthor{
    return _prefs.getString("gauthor") ?? "";
  }

  set gauthor(String value){
    _prefs.setString("gauthor", json.encode(value));
  }

}