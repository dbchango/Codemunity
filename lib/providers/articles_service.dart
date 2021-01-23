import 'dart:io';

import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/message_model.dart';
import 'package:code_munnity/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class ArticleService{
  String _urlRoot = fireStoreURL+"articles";
  Map<String, String> _headers = {"Content-Type": "application/json"};
  ArticleService();

  Future<String> _uploadImg(File image) async {
    final url = Uri.parse(cloudinaryURL);
    final mimeType = mime(image.path).split("/"); 
    final imageUploadReq = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath("file", image.path,
                        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadReq.files.add(file);
    final imageResponse = await imageUploadReq.send();
    final resp = await http.Response.fromStream(imageResponse);
    if ( resp.statusCode != 200 ){
      print('Error'+ resp.body);
      return null;
    }
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  Future<Message> _postarticle(Article article) async {
    final resp = await http.post(_urlRoot, headers: _headers, body: articleToJson(article));
    if(resp.body.isEmpty) return null;
    final decodedData = json.decode(resp.body);
    final message = new Message.fromJson(decodedData);
    return message;
  }

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
      final article = new Article.fromJson(decodedData);
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

  Future<Message> creatArticle(Article article) async {
    return await _postarticle(article);
  }

  Future<String> uploadImg(File img){
    return _uploadImg(img);
  }
}