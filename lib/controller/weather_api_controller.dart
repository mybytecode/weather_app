import 'dart:convert';

import 'package:fitmartweather/constants/constants.dart';
import 'package:fitmartweather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiController {
  Future<Weather> getCurrentWeatherDataForCity(double lat, double long) async {
    var response = await http.get(Const.BASE_URL +
        'onecall?lat=$lat&lon=$long&units=Fahrenheit&appid=' +
        Const.API_TOKEN);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    }
  }

  Future<List<Weather>> getPastWeatherDataForCity(
      double lat, double long) async {
    List<Weather> _weather = new List<Weather>();

    for (var i = 1; i <= 3; i++) {
      var time = DateTime.now()
              .subtract(Duration(days: i))
              .toUtc()
              .millisecondsSinceEpoch /
          1000;
      var t = time.toInt();
      var response = await http.get(Const.BASE_URL +
          'onecall/timemachine?dt=$t&lat=$lat&lon=$long&appid=' +
          Const.API_TOKEN);
      print(response.request.url);
      _weather.add(Weather.fromJson(json.decode(response.body)));
    }
    return _weather;
  }
}
