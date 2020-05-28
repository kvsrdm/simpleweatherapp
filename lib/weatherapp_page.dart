import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather.dart';

class WeatherApp {
  static const baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();

  Future<int> getLocID(String cityName) async {
    final cityUrl = baseUrl + "/api/location/search/?query=" + cityName;
    final response = await httpClient.get(cityUrl);

    if (response.statusCode != 200) {
      throw Exception("Error");
    }
    final responseJSON = (jsonDecode(response.body)) as List;

    debugPrint(response.body);

    return response.body == "[]" ? null : responseJSON[0]["woeid"];
  }

  Future<Weather> getWeather(int cityId) async {
    final weatherUrl = baseUrl + "/api/location/" + cityId.toString() + "/";
    final responseWeather = await httpClient.get(weatherUrl);

    if (responseWeather.statusCode != 200) {
      return null;
    }
    final responseWeatherJSON = jsonDecode(responseWeather.body);
    return Weather.fromJson(responseWeatherJSON);
  }

  Future<Weather> getResult(String city) async {
    final int cityId = await getLocID(city);
    return await getWeather(cityId);
  }
}
