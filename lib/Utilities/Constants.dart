import 'package:flutter/material.dart';

const String font_Family = "AKDR_FONT";

const kTempTextStyle = TextStyle(fontFamily: font_Family, fontSize: 100.0);

const kMessageTextStyle = TextStyle(fontFamily: font_Family, fontSize: 60.0);

const kButtonTextStyle = TextStyle(fontSize: 30.0, fontFamily: font_Family);

const kConditionTextStyle = TextStyle(fontSize: 100.0);

const kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    hintText: 'Enter City Name',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide.none));
