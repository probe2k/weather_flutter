import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:application/utils/location_helper.dart';

const apiKey = 'a80ec29757123fd25dde76bc5a87527e';

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  int currentTemperature, currentCondition;
  String currentLocation;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      print(currentWeather);

      try {
        currentTemperature = currentWeather['main']['temp'];
      }
    }
  }
}
