
import 'package:code_munnity/models/category.dart';
import 'package:code_munnity/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CategoriesService{
  String _urlRoot = fireStoreURL+"categories";
  //Map<String, String> _headers = {"Content-Type": "application/json"};
  CategoriesService();



  Future<Categories> _requestList(String url) async {
    print(url);
    try{
      final resp = await http.get(url);
      if(resp.body.isEmpty) return null;
      final decodeData = json.decode(resp.body);
      
      final categories = new Categories.fromJsonList(decodeData);
      return categories;
    }on Exception catch (err){
      print("Exception $err");
      return null;
    }
  }

  Future<Category> _request(String url) async{
    try{
      final resp = await http.get(url);
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final category = Category.fromJsonMap(decodedData);
      return category;
    }on Exception catch (e){
      print("Exception $e");
      return null;
    }
  }

  Future<Categories> getCategories() async {
    String path = _urlRoot;
    return await _requestList(path);
  }

  Future<Category> getCategory(String id) async {
    String path = "$_urlRoot/$id";
    return await _request(path);
  }
  
}