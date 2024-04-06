import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  static final WeatherProvider _instance = WeatherProvider._internal();

  factory WeatherProvider() {
    return _instance;
  }

  WeatherProvider._internal();

  void setWeather(Weather weather) {
    _weather = weather;
    notifyListeners();
  }
}
