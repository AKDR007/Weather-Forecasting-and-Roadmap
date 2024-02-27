import 'package:akdr_weather/Services/Location.dart';
import 'package:akdr_weather/Services/Networking.dart';

const apikey = 'Your OpenWeather API KEY';

String loc = "";

class LOCDAT {
  void USRLOC(String Loc) {
    Loc = Loc.toUpperCase();
    loc = Loc;
  }
}

class WeatherModel {
  double longitude = 0;
  double latitude = 0;

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.lat;
    longitude = location.long;
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩\t$loc';
    } else if (condition < 400) {
      return '🌧\t$loc';
    } else if (condition < 600) {
      return '☔️\t$loc';
    } else if (condition < 700) {
      return '☃️\t$loc';
    } else if (condition < 800) {
      return '🌫\t$loc';
    } else if (condition == 800) {
      return '☀️\t$loc';
    } else if (condition <= 804) {
      return '☁️\t$loc';
    } else {
      return '🤷\t$loc';
    }
  }

  String getWeatherImage(int condition) {
    if (condition < 10) {
      return 'Snow';
    } else if (condition < 20) {
      return 'Winter';
    } else if (condition < 26) {
      return 'Rain';
    } else if (condition >= 26) {
      return 'Sun';
    } else {
      return "Error Fetching Data";
    }
  }
}
