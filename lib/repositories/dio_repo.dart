import 'package:dio/dio.dart';
import 'package:simple_weather/models/city_model.dart';
import 'package:simple_weather/models/weather_model.dart';

class WeatherRepo {
  final Dio dio;
  WeatherRepo(this.dio);

  Future<MainWeatherModel> getResponse(double lat, double lon) async {
    final response = await dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': lat,
        'longitude': lon,
        'hourly':
            'temperature_2m,precipitation_probability,weather_code,wind_speed_10m',
        'daily':
            'temperature_2m_max,temperature_2m_min,wind_speed_10m_max,weather_code',
        'timezone': 'auto',
      },
    );
    return MainWeatherModel.fromMap(response.data as Map<String, dynamic>);
  }
}

class GeoRepo {
  final Dio dio;
  GeoRepo(this.dio);

  Future<List<CityModel>> searchCity(String name) async {
    final response = await dio.get(
      'https://geocoding-api.open-meteo.com/v1/search',
      queryParameters: {
        'name': name,
        'count': 20,
        'language': 'uk',
        'format': 'json',
      },
    );

    final List<dynamic> results = response.data['results'] ?? [];
    return results
        .map((cityMap) => CityModel.fromMap(cityMap))
        .where((city) => city.countryCode == 'UA')
        .toList();
  }
}
