import 'dart:convert';
import 'package:code_munnity/models/library.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class LibrariesService {
  
  LibrariesService();

  Future<Libraries> getAll() async=> rootBundle.loadString("assets/data/data.json").then((value){return Libraries.fromJsonList(json.decode(value));});

}
