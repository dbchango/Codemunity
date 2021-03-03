import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/models/category.dart';
import 'package:code_munnity/utils/label.dart';
import  'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));
String articleToJson(Article data) => json.encode(data.toJson());

class Article{
  String id;
  String title;
  Date date;
  References references;
  String idcategory;
  String idauthor;
  String abstract;
  Labels labels;
  String content;
  Author author;
  int readers;
  int stars;
  String imgurl;
  Category category;

  Article({
    this.id,
    this.title,
    this.idauthor,
    this.labels,
    this.content,
    this.author,
    this.readers,
    this.stars,
    this.date,
    this.references,
    this.imgurl,
    this.idcategory,
    this.category,
    this.abstract
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id : json['id'],
      title : json['title'],
      labels : Labels.fromJsonList(json['labels']),
      idauthor : json['idauthor'],
      author : Author.fromJsonMap(json['author']),
      content : json['content'],
      abstract : json['abstract'],
      stars : json['stars'],
      readers : json['readers'],
      references: References.fromJsonList(json['references']),
      date: Date.fromJson(json["date"]),
      imgurl: json['imgurl'],
      idcategory: json['idcategory'],
      category:Category.fromJsonMap(json['category'])
  );

  Map<String, dynamic> toJson() => {
    "id": id, 
    "title": title, 
    "idauthor": idauthor,
    "labels": labels.items, 
    "content": content, 
    "author": author,
    "readers": readers,
    "stars": stars, 
    "references": references.toJson(),
    "imgurl" : imgurl,
    "date" : date,
    "idcategory" :idcategory,
    "abstract" : abstract
  };
}

class Reference{
  String reference;
  Reference({this.reference});
  Reference.fromJsonMap(String json){
    reference = json;
  }
  
}

class References{
  List<Reference> references = List();
  References();
  References.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final ref = Reference.fromJsonMap(item);
      references.add(ref);
    }
  }

  List<String> toJson(){
    List<String> list = new List();
    references.forEach((element) {
      list.add(element.reference);
    });
    return list;
  }

  
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

class Date {
    Date({
        this.seconds,
        this.nanoseconds,
    });

    int seconds;
    int nanoseconds;

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
    );

    Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
    };
}
