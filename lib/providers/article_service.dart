import 'package:code_munnity/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ArticleService{
  String _urlRoot = "https://consultoriovet-eb010.web.app/api/articles";

  ArticleService();

  Future<Articles> _requestList(String url) async {
    print(url);
    try{
      final resp = await http.get(url);
      if(resp.body.isEmpty) return null;
      final decodeData = json.decode(resp.body);
      
      final articles = new Articles.fromJsonList(decodeData);
      return articles;
    }on Exception catch (err){
      print("Exception $err");
      return null;
    }
  } 

  Future<Article> _request(String url) async{
    try{
      final resp = await http.get(url);
      if (resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final article = new Article.fromJsonMap(decodedData);
      return article;
    }on Exception catch (e){
      print("Exception $e");
      return null;
    }
  }

  Future<Articles> getArticles() async {
    String path = _urlRoot;
    return await _requestList(path);
  }

  Future<Article> getArticle(String id) async {
    String path = "$_urlRoot/$id";
    return await _request(path);
  }
}