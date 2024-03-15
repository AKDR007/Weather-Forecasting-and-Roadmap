import 'package:flutter/material.dart';
import 'LocationAct.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:akdr_weather/Services/Weather.dart';

class Loading extends StatefulWidget {
  Loading({this.C_Name});

  final C_Name;

  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel WM = WeatherModel();

    var WD = await WM.getCityWeather(widget.C_Name);
    print(WD['coord']['lon']);
    print(WD['coord']['lat']);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationAct(locationWeather: WD);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
