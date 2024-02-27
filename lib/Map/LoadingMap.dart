import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:akdr_weather/Services/Weather.dart';

import 'Map.dart';

class LoadingMap extends StatefulWidget {
  LoadingMap({this.cityName});

  final cityName;

  @override
  _LoadingMap createState() => _LoadingMap();
}

class _LoadingMap extends State<LoadingMap> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather((widget.cityName));
//print(weatherData['coord]['lon]);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GoogleMa(LocationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100.0),
      ),
    );
  }
}
