import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/service/weather_provider.dart';

class DateTimeInfo extends StatelessWidget {
  const DateTimeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = WeatherProvider().weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Text(
              ", ${DateFormat("dd.MM.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
