import 'package:code_munnity/models/article.dart';

class UserCollection{
  String id;
  String name;
  String idUser;
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