import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/utils/label.dart';

class Article{
  String id;
  String title;
  String idauthor;
  Labels labels;
  Author author;
  Article({this.id, this.title, this.labels});
  Article.fromJsonMap(Map<dynamic, dynamic>json){
    if(json!=null){
      id = json['id'];
      title = json['title'];
      labels = Labels.fromJsonList(json['labels']);
      idauthor = json['idauthor'];
      author = Author.fromJsonMap(json['author']);
    }
  }
}

class Articles{
  List<Article> items = List();
  Articles();
  Articles.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final article = Article.fromJsonMap(item);
      items.add(article);
    }
  }
}

