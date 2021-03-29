



class Label{
  String name;

  Label({this.name});
  Label.fromJsonMap(Map<dynamic, dynamic> json){
    name = json['name'];

  }

  Map<String, dynamic> toJson()=>{
    "name" : name
  };
}
class Labels{
  List<Label> items = List();
  Labels();
  Labels.fromJsonList(List<dynamic> jsonList){
    for(var item in jsonList){
      final label = Label.fromJsonMap(item);
      items.add(label);
    }
  }
  List<Map<dynamic, dynamic>> toJson(){
    List<Map<dynamic, dynamic>> list = new List();
    items.forEach((element) {
      list.add(element.toJson());
    });
    return list;
  }


}