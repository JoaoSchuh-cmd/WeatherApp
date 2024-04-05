import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather.dart';

class CurrentTemp extends StatelessWidget {
  const CurrentTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${WeatherProvider().weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(fontSize: 90, fontWeight: FontWeight.w500),
    );
  }
}
