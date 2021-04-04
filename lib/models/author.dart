
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
  String uid;
  
  Author({ this.id, this.name, this.surname, this.mail, this.knowledgearea, this.about, this.avatarimgurl, this.uid });
  factory Author.fromJsonMap(Map<dynamic, dynamic> json) => Author(
      id : json['id'],
      name : json['name'],
      surname : json['surname'],
      mail : json['mail'],
      knowledgearea : json['knowledgearea'],
      about : json['about'],
      avatarimgurl : json['avatarimgurl'],
      uid: json['uid']
  );

  factory Author.fromJson(dynamic json){
    return Author(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      mail: json['mail'] as String,
      knowledgearea: json['knowledgearea'] as String,
      about : json['about'] as String,
      avatarimgurl : json['avatarimgurl'] as String,
      uid : json['uid'] as String,
      
    );
  }
  
  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "surname" : surname,
    "mail" : mail,
    "knowledgearea" : knowledgearea,
    "about" : about,
    "avatarimgurl" : avatarimgurl,
    "uid":uid
  };

  String toJsonString()  {
    return '{"id":"${id}", "name":"${name}", "surname":"${surname}", "mail":"${mail}", "knowledgearea":"${knowledgearea}", "about":"${about}", "avatarimgurl":"${avatarimgurl}", "uid":"${uid}"}' ;
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
