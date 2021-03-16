import 'package:code_munnity/models/location.dart';

class Institute{
  String name;
  Location location;
  
  Institute({
    this.name, 
    this.location
  });

  factory Institute.fromJson(Map<String, dynamic> json) => Institute(
    name:json["name"],
    location: Location.fromJson(json)
  );

}

class Institutes{
  List<Institute> items = List();
  Institutes();
  Institutes.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    for (var item in jsonList) {
      final lib = Institute.fromJson(item);
      items.add(lib);
    }
  }

}