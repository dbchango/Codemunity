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

class Categories{
  List<Category> items = List();
  Categories();
  
  Categories.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final ctg = Category.fromJsonMap(item);
      items.add(ctg);
    }
  }
}