import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/standby_models.dart';

class WeatherService {
  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<WeatherSnapshot> fetchLondonWeather() async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '51.5072',
      'longitude': '-0.1276',
      'current': 'temperature_2m,weather_code',
      'timezone': 'auto',
    });

    final response = await _client.get(uri).timeout(const Duration(seconds: 6));
    if (response.statusCode != 200) {
      throw StateError('Weather request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, Object?>;
    final current = body['current'] as Map<String, Object?>?;
    final temp = (current?['temperature_2m'] as num?)?.round() ?? 18;
    return WeatherSnapshot(
      city: 'London',
      condition: _conditionForCode((current?['weather_code'] as num?)?.round()),
      temperatureCelsius: temp,
      highCelsius: temp + 3,
      lowCelsius: temp - 5,
      updatedAt: DateTime.now(),
    );
  }

  String _conditionForCode(int? code) {
    if (code == null) return 'Local weather';
    if (code == 0) return 'Clear';
    if (code < 4) return 'Partly cloudy';
    if (code < 70) return 'Rain nearby';
    return 'Atmospheric';
  }
}
