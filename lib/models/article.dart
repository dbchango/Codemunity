import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/utils/label.dart';
import  'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));
String articleToJson(Article data) => json.encode(data.toJson());

class Article{
  String id;
  String title;
  String idauthor;
  Labels labels;
  String content;
  Author author;
  int readers;
  int stars;

  Article({
    this.id, 
    this.title, 
    this.idauthor,
    this.labels, 
    this.content, 
    this.author,
    this.readers,
    this.stars, 
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id : json['id'],
      title : json['title'],
      labels : Labels.fromJsonList(json['labels']),
      idauthor : json['idauthor'],
      author : Author.fromJsonMap(json['author']),
      content : json['content'],
      stars : json['stars'],
      readers : json['readers']
  );

  Map<String, dynamic> toJson() => {
    "id": id, 
    "title": title, 
    "idauthor": idauthor,
    "labels": labels, 
    "content": content, 
    "author": author,
    "readers": readers,
    "stars": stars, 
  };
}

class Articles{
  List<Article> items = List();
  Articles();
  Articles.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final article = Article.fromJson(item);
      items.add(article);
    }
  }
}

