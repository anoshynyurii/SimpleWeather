import 'package:flutter/material.dart';
import 'package:simple_weather/theme/theme.dart';
import 'package:simple_weather/utils/weather_translator.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<String> times;
  final List<double> temps;
  final List<int> wmoCodes;

  const HourlyWeatherList({
    super.key,
    required this.times,
    required this.temps,
    required this.wmoCodes,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        itemBuilder: (context, index) {
          final hour = DateTime.parse(times[index]).hour;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  maxLines: 1,
                  '$hour:00',
                  style: const TextStyle(
                    color: AppColors.darkThemeText,
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Icon(
                  WeatherTranslator.getWeatherIcon(wmoCodes[index]),
                  color: AppColors.darkThemeText,
                  size: 32,
                ),
                const SizedBox(height: 6),
                Text(
                  maxLines: 1,
                  '${temps[index].round()}°',
                  style: const TextStyle(
                    color: AppColors.darkThemeText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
