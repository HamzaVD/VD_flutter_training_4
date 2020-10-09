import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/global.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:weatherapp/weather_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Unit Testing Weather app', () {
    test('Calling Weather API Test', () {
      final client = MockClient();
      String cityName = 'Chicago';
      when(client.get(
              'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${Global.apiKey}'))
          .thenAnswer((_) async => http.Response(
              '{"coord":{"lon":-87.65,"lat":41.85},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":286.42,"feels_like":284.42,"temp_min":285.15,"temp_max":287.59,"pressure":1019,"humidity":76},"visibility":10000,"wind":{"speed":2.6,"deg":120},"clouds":{"all":1},"dt":1602226648,"sys":{"type":1,"id":4861,"country":"US","sunrise":1602244594,"sunset":1602285512},"timezone":-18000,"id":4887398,"name":"Chicago","cod":200}',
              200));

      expect(WeatherService.getWeatherData(cityName, client),
          isA<Future<WeatherResponse>>());
    });
  });
}
