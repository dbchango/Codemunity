
import 'package:code_munnity/models/message_model.dart';
import 'package:code_munnity/models/quill_article.dart';
import 'package:code_munnity/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class QuillArticlesService{
  String _urlRoot = fireStoreURL+"quillarticles";
  Map<String, String> _headers = {"Content-Type": "application/json"};
  QuillArticlesService();

  Future<Message> _postQuillArticle(QuillArticle qa) async{
    final resp = await http.post(_urlRoot, headers: _headers, body: quillArticleToJson(qa));
    if(resp.body.isEmpty) return null;
    final decodedData = json.decode(resp.body);
    final message = new Message.fromJson(decodedData);
    return message;

  }

  Future<QuillArticle> _retrieveQuillArticle(String url) async{
    try{
      final resp = await http.get(url);
      if(resp.body.isEmpty) return null;
      final decodedData = json.decode(resp.body);
      final quill = new QuillArticle.fromJsonMap(decodedData);
      return quill;
    }on Exception catch (e){
      print("Exception $e");
      return null;
    }
  }

  Future<Message> createQuillArticle(QuillArticle qa) async{
    return await _postQuillArticle(qa);
  }

  Future<QuillArticle> retrieveQuill(String id) async{
    String path = "$_urlRoot/$id";
    return await _retrieveQuillArticle(path);
  }
}