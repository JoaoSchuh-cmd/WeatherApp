import 'package:flutter/material.dart';
import 'package:weatherapp/service/weather_provider.dart';

class LocationHeader extends StatefulWidget {
  const LocationHeader({super.key});

  @override
  State<LocationHeader> createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader> {
  @override
  Widget build(BuildContext context) {
    return Text(WeatherProvider().weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ));
  }
}
