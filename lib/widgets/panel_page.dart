import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/constants/colors.dart';
import 'package:weatherapp/model/location.dart';
import 'package:weatherapp/pages/addlocation_page.dart';
import 'package:weatherapp/service/locations_service.dart';
import 'package:weatherapp/service/weather_provider.dart';
import 'package:weatherapp/service/current_location_service.dart';
import 'package:weatherapp/widgets/current_temp.dart';
import 'package:weatherapp/widgets/datetime_info.dart';
import 'package:weatherapp/widgets/extra_info.dart';
import 'package:weatherapp/widgets/location_header.dart';
import 'package:weatherapp/widgets/wather_icon.dart';
import 'package:weatherapp/constants/constants.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  late double lat;
  late double lon;

  @override
  void initState() {
    super.initState();
    if (LocationsService().getLocations().isEmpty) {
      LocationsService()
          .addLocation(Location(cityName: "Curitiba", selected: false));
      LocationsService()
          .addLocation(Location(cityName: "Toledo", selected: true));
    }

    CurrentLocationService().requestLocationPermission().then((value) {
      if (value) {
        _getWeatherByCurrentLocation();
      } else {
        _getWeatherByLocationsList();
      }
    });
  }

  void _getWeatherByLocationsList() {
    final locations = LocationsService().getLocations();
    for (final location in locations) {
      if (location.selected) {
        _getWeather(location.cityName);
        return;
      }
    }
  }

  void _getWeatherByCurrentLocation() {
    CurrentLocationService().getCurrentLocation().then((value) {
      if (value != null) {
        lat = value.latitude;
        lon = value.longitude;
        _getWeather("");
      }
    });
  }

  void _getWeather(String cityName) {
    if (cityName.isNotEmpty) {
      _wf.currentWeatherByCityName(cityName).then((w) {
        setState(() {
          WeatherProvider().setWeather(w);
        });
      });
    } else {
      _wf.currentWeatherByLocation(lat, lon).then((w) {
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
        child: CircularProgressIndicator(
          backgroundColor: Colors.black,
          color: cWhite,
        ),
      );
    }
    return Stack(
      children: [
        Container(
          color: Colors.blue.shade100,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocationHeader(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
              DateTimeInfo(),
              WeatherIcon(),
              CurrentTemp(),
              ExtraInfo(),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.025,
          //left: 10,
          child: IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.add,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddLocationPage()));

              if (result != null) {
                _getWeather(result);
              }
            },
          ),
        ),
      ],
    );
  }
}
