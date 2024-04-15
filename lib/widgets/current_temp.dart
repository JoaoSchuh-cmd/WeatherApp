import 'package:flutter/material.dart';
import 'package:weatherapp/service/weather_provider.dart';

class CurrentTemp extends StatefulWidget {
  const CurrentTemp({super.key});

  @override
  State<CurrentTemp> createState() => _CurrentTempState();
}

class _CurrentTempState extends State<CurrentTemp> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${WeatherProvider().weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(fontSize: 90, fontWeight: FontWeight.w500),
    );
  }
}
