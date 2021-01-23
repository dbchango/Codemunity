

class Author{
  String id;
  String name;
  String surname;
  String mail;
  String knowledgearea;
  String about;
  String avatarimgurl;
  
  Author({ this.id, this.name, this.surname, this.mail, this.knowledgearea, this.about, this.avatarimgurl });
  Author.fromJsonMap(Map<dynamic, dynamic> json){
    if(json!=null){
      id = json['id'];
      name = json['name'];
      surname = json['surname'];
      mail = json['mail'];
      knowledgearea = json['knowledgearea'];
      about = json['about'];
      avatarimgurl = json['avatarimgurl'];
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
