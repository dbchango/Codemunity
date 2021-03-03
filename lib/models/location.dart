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

}

