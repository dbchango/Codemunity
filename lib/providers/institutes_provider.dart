import 'dart:convert';
import 'dart:async';
import 'package:code_munnity/models/library.dart';
import 'package:flutter/services.dart' show rootBundle;

class InstituteService{
  InstituteService();

  Future<Institutes> getAll() async=> rootBundle.loadString("assets/data/data.json").then((value){return Institutes.fromJsonList(json.decode(value));});
}