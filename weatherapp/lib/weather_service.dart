import 'dart:convert';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather_model.dart';

class WeatherService {
  static Future<WeatherResponse> getWeatherData(
      String cityName, http.Client client) async {
    var response = await client.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${Global.apiKey}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return WeatherResponse.fromJson(json.decode(response.body));
  }
}
