class Weather {
  final List<Daily> daily;
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;

  Weather(
      {this.daily,
      this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        daily: json['daily'] != null
            ? (json['daily'] as List).map((i) => Daily.fromJson(i)).toList()
            : null,
        lat: json['lat'],
        lon: json['lon'],
        timezone: json['timezone'],
        timezoneOffset: json['timezone_offset'],
        current: Current.fromJson(json['current']));
  }
}

class Current {
  final int clouds;
  final dewPoint;
  final int dt;
  final feelsLike;
  final int humidity;
  final int pressure;
  final int sunrise;
  final int sunset;
  final temp;
  final uvi;
  final int visibility;
  final List<WeatherX> weather;
  final int windDeg;
  final windSpeed;

  Current(
      {this.clouds,
      this.dewPoint,
      this.dt,
      this.feelsLike,
      this.humidity,
      this.pressure,
      this.sunrise,
      this.sunset,
      this.temp,
      this.uvi,
      this.visibility,
      this.weather,
      this.windDeg,
      this.windSpeed});

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      clouds: json['clouds'],
      dewPoint: json['dew_point'],
      dt: json['dt'],
      feelsLike: json['feels_like'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'],
      uvi: json['uvi'],
      visibility: json['visibility'],
      weather: json['weather'] != null
          ? (json['weather'] as List).map((i) => WeatherX.fromJson(i)).toList()
          : null,
      windDeg: json['wind_deg'],
      windSpeed: json['wind_speed'],
    );
  }
}

class WeatherX {
  final String description;
  final String icon;
  final int id;
  final String main;

  WeatherX({this.description, this.icon, this.id, this.main});

  factory WeatherX.fromJson(Map<String, dynamic> json) {
    return WeatherX(
      description: json['description'],
      icon: json['icon'],
      id: json['id'],
      main: json['main'],
    );
  }
}

class Daily {
  final int clouds;
  final dewPoint;
  final int dt;
  final FeelsLike feelsLike;
  final int humidity;
  final int pressure;
  final rain;
  final int sunrise;
  final int sunset;
  final Temp temp;
  final uvi;
  final List<WeatherXX> weather;
  final int windDeg;
  final windSpeed;

  Daily(
      {this.clouds,
      this.dewPoint,
      this.dt,
      this.feelsLike,
      this.humidity,
      this.pressure,
      this.rain,
      this.sunrise,
      this.sunset,
      this.temp,
      this.uvi,
      this.weather,
      this.windDeg,
      this.windSpeed});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      clouds: json['clouds'],
      dewPoint: json['dew_point'],
      dt: json['dt'],
      feelsLike: json['feels_like'] != null
          ? FeelsLike.fromJson(json['feels_like'])
          : null,
      humidity: json['humidity'],
      pressure: json['pressure'],
      rain: json['rain'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'] != null ? Temp.fromJson(json['temp']) : null,
      uvi: json['uvi'],
      weather: json['weather'] != null
          ? (json['weather'] as List).map((i) => WeatherXX.fromJson(i)).toList()
          : null,
      windDeg: json['wind_deg'],
      windSpeed: json['wind_speed'],
    );
  }
}

class Temp {
  final day;
  final eve;
  final max;
  final min;
  final morn;
  final night;

  Temp({this.day, this.eve, this.max, this.min, this.morn, this.night});

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'],
      eve: json['eve'],
      max: json['max'],
      min: json['min'],
      morn: json['morn'],
      night: json['night'],
    );
  }
}

class FeelsLike {
  final day;
  final eve;
  final morn;
  final night;

  FeelsLike({this.day, this.eve, this.morn, this.night});

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json['day'],
      eve: json['eve'],
      morn: json['morn'],
      night: json['night'],
    );
  }
}

class WeatherXX {
  final String description;
  final String icon;
  final int id;
  final String main;

  WeatherXX({this.description, this.icon, this.id, this.main});

  factory WeatherXX.fromJson(Map<String, dynamic> json) {
    return WeatherXX(
      description: json['description'],
      icon: json['icon'],
      id: json['id'],
      main: json['main'],
    );
  }
}
