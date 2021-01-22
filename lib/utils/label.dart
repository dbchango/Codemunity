class Label{
  String name;

  Label({this.name});
  Label.fromJsonMap(Map<dynamic, dynamic> json){
    name = json['name'];

  }
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
}