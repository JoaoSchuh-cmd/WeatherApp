import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/service/location_service.dart';
import 'package:weatherapp/widgets/current_temp.dart';
import 'package:weatherapp/widgets/datetime_info.dart';
import 'package:weatherapp/widgets/extra_info.dart';
import 'package:weatherapp/widgets/location_header.dart';
import 'package:weatherapp/widgets/wather_icon.dart';
import 'package:weatherapp/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  late double lat;
  late double lon;
  late bool teste;

  @override
  void initState() {
    super.initState();
    LocationService().requestLocationPermission().then((value) {
      if (value) {
        _getCurrentLocation();
      } else {
        lat = 0.00;
        lon = 0.00;
      }
    });
  }

  void _getCurrentLocation() {
    LocationService().getCurrentLocation().then((value) {
      if (value != null) {
        lat = value.latitude;
        lon = value.longitude;
      }
      _getWeather();
    });
  }

  void _getWeather() {
    if (lat != 0.00 && lon != 0.00) {
      _wf.currentWeatherByLocation(lat, lon).then((w) {
        setState(() {
          WeatherProvider().setWeather(w);
        });
      });
    } else {
      _wf.currentWeatherByCityName("Curitiba").then((w) {
        setState(() {
          WeatherProvider().setWeather(w);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (WeatherProvider().weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      color: Colors.blue.shade100,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LocationHeader(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
          const DateTimeInfo(),
          const WeatherIcon(),
          const CurrentTemp(),
          const ExtraInfo(),
        ],
      ),
    );
  }
}
