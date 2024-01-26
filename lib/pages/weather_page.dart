import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('a3f85055873f7d8ad76dad45ec36d270');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city.."),

            //temperture
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}
