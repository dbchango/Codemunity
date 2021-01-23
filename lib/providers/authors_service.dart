import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ArticleService{
  String _urlRoot = fireStoreURL+"authors";

  ArticleService();

  Future<Authors> _requestList(String url) async {
    print(url);
    try{
      final resp = await http.get(url);
      if(resp.body.isEmpty) return null;
      final decodeData = json.decode(resp.body);
      final authors = new Authors.fromJsonList(decodeData);
      return authors;
    }on Exception catch (err){
      print("Exception $err");
      return null;
    }
  } 

  Future<Author> _request(String url) async{
    try{
      final resp = await http.get(url);
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final author = new Author.fromJsonMap(decodedData);
      return author;
    }on Exception catch (e){
      print("Exception $e");
      return null;
    }
  }

  Future<Authors> getAuthors() async {
    String path = _urlRoot;
    return await _requestList(path);
  }

  Future<Author> getAuthor(String id) async {
    String path = "$_urlRoot/$id";
    return await _request(path);
  }
}