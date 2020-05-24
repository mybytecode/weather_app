import 'package:fitmartweather/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.blue,
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
