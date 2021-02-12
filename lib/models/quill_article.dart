
import  'dart:convert';

String quillArticleToJson(QuillArticle data) => json.encode(data.toJson());

class QuillArticle{
  String id;
  String title;
  String content;

  QuillArticle({
    this.id,
    this.title,
    this.content
  });

  QuillArticle.fromJsonMap(Map<String, dynamic> json){
    if(json!=null){
      id = json['id'];
      title = json['title'];
      content = json['content'];
    } 
  }

  Map<String, dynamic> toJson()=>{
    "id": id,
    "title": title,
    "content" : content
  };
}

class QuillArticles{
  List<QuillArticle> list = new List();
  QuillArticles();
  QuillArticles.fromJsonList(List<dynamic> jsonList){
    if(jsonList!=null){
      for(var item in jsonList){
        final ref = QuillArticle.fromJsonMap(item);
        list.add(ref);
      }
    }

  }

}