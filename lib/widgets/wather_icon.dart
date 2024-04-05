import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key});

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
