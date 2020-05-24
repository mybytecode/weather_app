import 'dart:convert';

import 'package:fitmartweather/model/cities.dart';
import 'package:flutter/services.dart';

class CitiesController {
  Future<List<Cities>> getCities() async {
    String data = await rootBundle.loadString('assets/cities_list.json');
    return parseJson(data);
  }

  List<Cities> parseJson(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Cities>((json) => Cities.fromJson(json)).toList();
  }
}
