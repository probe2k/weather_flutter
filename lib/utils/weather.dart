import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:application/utils/location_helper.dart';

const apiKey = 'a80ec29757123fd25dde76bc5a87527e';

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  int currentCondition;
  double currentTemperature;
  String currentLocation;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      print(currentWeather);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentLocation = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print('could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: Icon(
          FontAwesomeIcons.cloud,
          size: 50,
          color: Colors.white,
        ),
        weatherImage: AssetImage(
          'asset/cloud.png',
        ),
      );
    } else {
      var now = DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloudMoon,
            size: 50,
            color: Colors.white,
          ),
          weatherImage: AssetImage(
            'asset/night.png',
          ),
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloudSun,
            size: 50,
            color: Colors.white,
          ),
          weatherImage: AssetImage(
            'asset/sunny.png',
          ),
        );
      }
    }
  }
}

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}
