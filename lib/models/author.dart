import 'package:code_munnity/models/user_collection.dart';

class Author{
  String id;
  String name;
  String surname;
  String mail;
  String knowledgearea;
  String about;
  String avatar;
  Articles favorites;
  Author({ this.id, this.name, this.surname, this.mail, this.knowledgearea, this.about, this.avatar });
  Author.fromJsonMap(Map<dynamic, dynamic> json){
    if(json!=null){
      id = json['id'];
      name = json['name'];
      surname = json['surname'];
      mail = json['mail'];
      knowledgearea = json['knowledgearea'];
      about = json['about'];
      avatar = json['avatar'];
    } 
  }
}

class Authors{

  List<Author> items = List();
  Authors();
  Authors.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final author = Author.fromJsonMap(item);
      items.add(author);
    }
  }
}
