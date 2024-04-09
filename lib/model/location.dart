import 'package:weatherapp/service/locations_service.dart';

class Location {
  int id;
  String cityName;
  bool selected;
  //final double lat;
  //final double lon;

  Location({
    required this.cityName,
    this.selected = false,
    //required this.lat,
    //required this.lon,
  }) : id = LocationsService().getLastId() + 1;
}
