import 'package:flutter/material.dart';
import 'package:simple_weather/theme/theme.dart';

class CityStatsListWidget extends StatelessWidget {
  final Map<String, int> cities;

  const CityStatsListWidget({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    if (cities.isEmpty) {
      return const Text('Немає даних по містах');
    }

    return Card(
      elevation: 2,
      color: AppColors.containers,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cities.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final cityName = cities.keys.elementAt(index);
          final count = cities.values.elementAt(index);
          return ListTile(
            title: Text(
              cityName,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.darkThemeText,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
