import 'package:flutter/material.dart';
import 'package:weatherapp/service/weather_provider.dart';

class WeatherIcon extends StatefulWidget {
  const WeatherIcon({super.key});

  @override
  State<WeatherIcon> createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${WeatherProvider().weather?.weatherIcon}@4x.png"))),
        )
      ],
    );
  }
}
