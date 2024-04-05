import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/widgets/panel_page.dart';
import 'package:weatherapp/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Toronto").then((w) {
      setState(() {
        WeatherProvider().setWeather(w);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: PanelPage());
  }
}
