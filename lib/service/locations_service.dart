import 'package:flutter/material.dart';
import 'package:weatherapp/model/location.dart';

class LocationsService extends ChangeNotifier {
  List<Location>? _locationsList;

  List<Location>? get locationsList => _locationsList;

  static final LocationsService _instance = LocationsService._internal();

  factory LocationsService() {
    return _instance;
  }

  LocationsService._internal();

  List<Location>? getLocations() {
    return _locationsList;
  }

  Location? getLocationById(int id) {
    return locationsList?.firstWhere((element) => element.id == id);
  }

  void addLocation(Location location) {
    locationsList?.add(location);
  }

  void updateLocation(int id, Location updatedLocation) {
    var index = locationsList!.indexWhere((element) => element.id == id);
    if (index != -1) {
      locationsList?[index] = updatedLocation;
    }
  }

  void deleteLocation(int id) {
    locationsList?.removeWhere((element) => element.id == id);
  }
}
