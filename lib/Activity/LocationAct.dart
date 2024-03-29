import 'package:flutter/material.dart';
import 'package:akdr_weather/Map/LoadingMap.dart';
import 'package:akdr_weather/Activity/City.dart';
import 'package:akdr_weather/Utilities/Constants.dart';
import 'package:akdr_weather/Services/Weather.dart';

class LocationAct extends StatefulWidget {
  LocationAct({this.locationWeather});

  final locationWeather;

  @override
  _LocationAct createState() => _LocationAct();
}

class _LocationAct extends State<LocationAct> {
  WeatherModel weather = WeatherModel();

  int temp = 0;
  String WeatherICON = "";
  String City = "";
  String ImageName = "";

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        WeatherICON = 'Error'; // city = '';
        return;
      }

      double tmp = weatherData['main']['temp'];
      temp = tmp.toInt();
      var condition = weatherData['weather'][0]['id'];
      WeatherICON = weather.getWeatherIcon(condition);
      ImageName = weather.getWeatherImage(temp);
      City = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(''),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();

                      updateUI(weatherData);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoadingMap(
                              cityName: City,
                            );
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      ); // print(typedName);
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherICON,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
