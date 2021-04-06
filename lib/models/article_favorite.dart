import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/models/category.dart';
import 'package:code_munnity/utils/label.dart';
import  'dart:convert';

ArticleFavorite articleFromJson(String str) => ArticleFavorite.fromJson(json.decode(str));
String articleToJson(ArticleFavorite data) => json.encode(data.toJson());

class ArticleFavorite{
  String id;
  String idUserFavorite;
  String idArticle;
  String title;
  Timestamp date;
  References references;
  String idcategory;
  String idauthor;
  String abstract;
  Labels labels;
  String content;
  Author author;
  String imgurl;
  Category category;

  ArticleFavorite({
    this.id,
    this.title,
    this.idauthor,
    this.labels,
    this.content,
    this.author,
    this.idUserFavorite,
    this.date,
    this.references,
    this.imgurl,
    this.idcategory,
    this.category,
    this.abstract,
    this.idArticle
  });

  factory ArticleFavorite.fromJson(Map<dynamic, dynamic> json) => ArticleFavorite(
      id : json['id'],
      title : json['title'],
      labels : Labels.fromJsonList(json['labels']),
      idauthor : json['idauthor'],
      author : Author.fromJsonMap(json['author']),
      content : json['content'],
      abstract : json['abstract'],
      references: References.fromJsonList(json['references']),
      date: json["date"],
      imgurl: json['imgurl'],
      idcategory: json['idcategory'],
      category:Category.fromJsonMap(json['category']),
      idUserFavorite:json['idUserFavorite'],
      idArticle: json['idArticle']
  );

  Map<String, dynamic> toJson() => {
    "title": title, 
    "idauthor": idauthor,
    "labels": labels.toJson(), 
    "category": category.toJson(),
    "content": content, 
    "author": author.toJson(),
    "references": references.toJson(),
    "imgurl" : imgurl,
    "date" : date,
    "idcategory" :idcategory,
    "abstract" : abstract,
    "idUserFavorite" : idUserFavorite,
    "id":id,
    "idArticle": idArticle
  };
}

class ArticleFavorites{
  List<ArticleFavorite> items = List();
  ArticleFavorites();
  ArticleFavorites.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final article = ArticleFavorite.fromJson(item);
      items.add(article);
    }
  }
}

class Date {
    Date({
        this.seconds,
        this.nanoseconds,
    });

    int seconds;
    int nanoseconds;

    factory Date.fromJson(Map<dynamic, dynamic> json) => Date(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
    );

    Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
    };
}
