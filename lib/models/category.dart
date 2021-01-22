class Category{
  String id;
  String name;
  String description;

  Category({this.id, this.name, this.description});

  Category.fromJsonMap(Map<dynamic, dynamic> json){
    if(json!=null){
      id = json['id'];
      name = json['name'];
      description = json['description'];
    }
  }
}