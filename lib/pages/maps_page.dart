import 'dart:async';
import 'package:code_munnity/models/library.dart';
import 'package:code_munnity/providers/institutes_provider.dart';
import 'package:code_munnity/providers/libraries_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapsPage extends StatefulWidget {
  MapsPage({Key key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  InstituteService _librariesService;
  Institutes _institutes;
  Set<Marker> _markers = new Set();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    
    super.initState();
    _librariesService = new InstituteService();
    _getLibreries();
  }


  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mapas"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            
            children: [
              SizedBox(
                  height: _heigth * 0.33,
                  child: Container(
                    child: GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                    color: Colors.grey,
                  )),
              
              
            ],
          ),
        ),
      ),
    );
  }

  void drawInstitutesLocations(){
    _institutes.items.forEach((element) {
      Marker mark = new Marker(
        markerId: MarkerId(element.name),
        infoWindow: InfoWindow(title: element.name),
        position: element.location.getGeo()
      ); 
    });
  }

  void _getLibreries(){
    _librariesService.getAll().then((value) {
      _institutes = value;
      print("after assign");
      _institutes.items.forEach((element) { print(element.name); });
    });
  }

}