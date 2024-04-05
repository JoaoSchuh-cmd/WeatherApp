import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/widgets/current_temp.dart';
import 'package:weatherapp/widgets/datetime_info.dart';
import 'package:weatherapp/widgets/extra_info.dart';
import 'package:weatherapp/widgets/location_header.dart';
import 'package:weatherapp/widgets/wather_icon.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
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
