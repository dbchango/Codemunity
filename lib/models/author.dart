
import 'dart:convert';
Author authorFromJson(String str) => Author.fromJsonMap(json.decode(str));
String authorToJson(Author data) => json.encode(data.toJson());
class Author{
  String id;
  String name;
  String surname;
  String mail;
  String knowledgearea;
  String about;
  String avatarimgurl;
  
  Author({ this.id, this.name, this.surname, this.mail, this.knowledgearea, this.about, this.avatarimgurl });
  factory Author.fromJsonMap(Map<dynamic, dynamic> json) => Author(
      id : json['id'],
      name : json['name'],
      surname : json['surname'],
      mail : json['mail'],
      knowledgearea : json['knowledgearea'],
      about : json['about'],
      avatarimgurl : json['avatarimgurl'],
  );
  
  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "surname" : surname,
    "mail" : mail,
    "knowledgearea" : knowledgearea,
    "about" : about,
    "avatarimgurl" : avatarimgurl
  };
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
