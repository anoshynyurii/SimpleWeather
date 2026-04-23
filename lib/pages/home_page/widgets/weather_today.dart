import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:simple_weather/models/weather_model.dart';
import 'package:simple_weather/theme/theme.dart';
import 'package:simple_weather/utils/weather_translator.dart';
import 'package:simple_weather/pages/home_page/widgets/weather_hourly_list.dart';

class WeatherToday extends StatelessWidget {
  final MainWeatherModel weather;
  final String cityName;

  const WeatherToday({
    super.key,
    required this.weather,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final hourly = weather.hourly;
    final now = DateTime.now();

    int currentIndex = hourly.time.indexWhere((timeStr) {
      final time = DateTime.parse(timeStr);
      return time.year == now.year &&
          time.month == now.month &&
          time.day == now.day &&
          time.hour == now.hour;
    });

    if (currentIndex == -1) {
      currentIndex = 0;
    }

    final currentTemp = hourly.temp2m.isNotEmpty
        ? hourly.temp2m[currentIndex]
        : 0.0;
    final currentWmo = hourly.wmo.isNotEmpty ? hourly.wmo[currentIndex] : 0;
    final currentWind = hourly.windSpeed10m.isNotEmpty
        ? hourly.windSpeed10m[currentIndex]
        : 0.0;

    final int limit = math.min(24, hourly.time.length);
    final safeTimes = limit > 0 ? hourly.time.sublist(0, limit) : <String>[];
    final safeTemps = limit > 0 ? hourly.temp2m.sublist(0, limit) : <double>[];
    final safeWmoCodes = limit > 0 ? hourly.wmo.sublist(0, limit) : <int>[];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.containers,
        borderRadius: BorderRadius.circular(32.0),
        gradient: SweepGradient(
          startAngle: 0.1,
          endAngle: 0.2,
          tileMode: TileMode.repeated,
          colors: [
            AppColors.containers,
            AppColors.containers.withAlpha(225),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Зараз, $cityName',
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.darkThemeText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                WeatherTranslator.getWeatherIcon(currentWmo),
                size: 64,
                color: AppColors.darkThemeText,
              ),
              const SizedBox(width: 16),
              Text(
                '${currentTemp.round()}°',
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.darkThemeText,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            WeatherTranslator.getWeatherDescription(currentWmo),
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.darkThemeText,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, color: AppColors.darkThemeText, size: 26),
              const SizedBox(width: 8),
              Text(
                '$currentWind км/год',
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.darkThemeText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.8,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          if (safeTimes.isNotEmpty)
            HourlyWeatherList(
              times: safeTimes,
              temps: safeTemps,
              wmoCodes: safeWmoCodes,
            )
          else
            const Text(
              'Немає погодинних даних',
              style: TextStyle(color: Colors.white54),
            ),
        ],
      ),
    );
  }
}
