import 'package:flutter/material.dart';
import 'package:akdr_weather/Activity/City.dart';
// import 'package:akdr_weather/Activity/Loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CityScreen(),
    );
  }
}
