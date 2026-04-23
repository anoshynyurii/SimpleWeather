import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:simple_weather/models/weather_model.dart';
import 'package:simple_weather/theme/theme.dart';
import 'package:simple_weather/utils/weather_translator.dart';
import 'package:simple_weather/pages/home_page/widgets/weather_hourly_list.dart';

class DailyForecastList extends StatelessWidget {
  final MainWeatherModel weather;
  const DailyForecastList({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final daily = weather.daily;
    final hourly = weather.hourly;

    if (daily.time.isEmpty) return const SizedBox.shrink();

    final int daysCount = math.min(7, daily.time.length);

    return Column(
      children: List.generate(daysCount, (index) {
        if (index == 0) return const SizedBox.shrink();

        final startHour = index * 24;
        final endHour = startHour + 24;

        List<T> getSafeList<T>(List<T> source) {
          if (startHour >= source.length) return [];
          final end = math.min(endHour, source.length);
          return source.sublist(startHour, end);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.containers,
              borderRadius: BorderRadius.circular(32),
            ),
            child: ExpansionTile(
              splashColor: Colors.transparent,
              childrenPadding: const EdgeInsets.only(top: 0),
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              leading: Icon(
                WeatherTranslator.getWeatherIcon(
                  daily.wmo.length > index ? daily.wmo[index] : 0,
                ),
                color: AppColors.darkThemeText,
                size: 30,
              ),
              title: Text(
                _getWeekdayName(daily.time[index]),
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.darkThemeText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Text(
                '${daily.temp2mMax.length > index ? daily.temp2mMax[index].round() : 0}°',
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.darkThemeText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 4),
                  child: HourlyWeatherList(
                    times: getSafeList(hourly.time),
                    temps: getSafeList(hourly.temp2m),
                    wmoCodes: getSafeList(hourly.wmo),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getWeekdayName(String date) {
    try {
      final dt = DateTime.parse(date);
      const days = [
        'Понеділок',
        'Вівторок',
        'Середа',
        'Четвер',
        'П\'ятниця',
        'Субота',
        'Неділя',
      ];
      return days[dt.weekday - 1];
    } catch (e) {
      return '';
    }
  }
}
