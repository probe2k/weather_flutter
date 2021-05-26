import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:application/utils/location_helper.dart';
import 'package:application/utils/weather.dart';
import 'package:application/screens/weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper _locationHelper;

  Future<void> getLocationData() async {
    _locationHelper = LocationHelper();
    await _locationHelper.getCurrentLocation();
    if (_locationHelper.longitude == null || _locationHelper.latitude == null) {
      print('data not fetched');
    } else {
      print(_locationHelper.latitude);
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: _locationHelper);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {}

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainScreen(
          weatherData: weatherData,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
              Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 150.0,
            duration: Duration(
              milliseconds: 1200,
            ),
          ),
        ),
      ),
    );
  }
}
