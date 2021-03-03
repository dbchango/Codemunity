import 'package:code_munnity/models/location.dart';

class Library{
  String name;
  Location location;
  
  Library({
    this.name, 
    this.location
  });

  factory Library.fromJson(Map<String, dynamic> json) => Library(
    name:json["name"],
    location: Location.fromJson(json)
  );

}

class Libraries{
  List<Library> items = List();
  Libraries();
  Libraries.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    for (var item in jsonList) {
      final lib = Library.fromJson(item);
      items.add(lib);
    }
  }

}