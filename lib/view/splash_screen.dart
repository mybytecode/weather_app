import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage( image: AssetImage('assets/bg.jpg'),fit: BoxFit.cover )
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 20.0, height: 100.0),
              Text(
                "Weather APP".toUpperCase(),
                style: TextStyle(fontSize: 43.0,color: Colors.white,fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20.0, height: 100.0),
            ],
          ),
        ),
      ),
    );
  }
}