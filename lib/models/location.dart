import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location{
  String longitud;
  String latitude;

  Location({
    this.longitud, 
    this.latitude
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    longitud: json['longitud'],
    latitude: json['latitude']
  );

  Map<String, dynamic> toJson()=>{
    "longitud" : longitud,
    "latitude" : latitude
  };

  LatLng getGeo() {
    if (double.tryParse(this.latitude) == null &&
        double.tryParse(this.longitud) == null) {
      return null;
    }

    double lat = double.parse(this.latitude);
    double lng = double.parse(this.longitud);
    return LatLng(lat, lng);
  }

}

