import 'package:flutter/material.dart';
import 'package:weatherapp/model/location.dart';

class LocationsService extends ChangeNotifier {
  List<Location> _locationsList = [];

  static final LocationsService _instance = LocationsService._internal();

  factory LocationsService() {
    return _instance;
  }

  LocationsService._internal();

  void setWeather(List<Location> locationsList) {
    _locationsList = locationsList;
    notifyListeners();
  }

  List<Location> getLocations() {
    return _locationsList;
  }

  Location getLocationById(int id) {
    return _locationsList.firstWhere((element) => element.id == id);
  }

  int getLastId() {
    int lastId = 0;
    for (final location in _locationsList) {
      if (location.id > lastId) {
        lastId = location.id;
      }
    }
    return lastId;
  }

  void addLocation(Location location) {
    _locationsList.add(location);
    notifyListeners();
  }

  void updateLocation(int id, Location updatedLocation) {
    var index = _locationsList.indexWhere((element) => element.id == id);
    if (index != -1) {
      _locationsList[index] = updatedLocation;
      notifyListeners();
    }
  }

  void deleteLocation(int id) {
    _locationsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
