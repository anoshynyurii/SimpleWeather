import 'package:flutter/material.dart';
import 'package:simple_weather/pages/stats_page/widgets/rating_button.dart';

class RatingWidget extends StatelessWidget {
  final String cityName;

  const RatingWidget({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Як вам прогноз на сьогодні?',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RatingButton(
              cityName: cityName,
              context: context,
              rating: 1,
              color: Colors.red,
              label: 'Погано',
            ),
            RatingButton(
              cityName: cityName,
              context: context,
              rating: 2,
              color: Colors.orange,
              label: 'Не точно',
            ),
            RatingButton(
              cityName: cityName,
              context: context,
              rating: 3,
              color: Colors.green,
              label: 'Чудово',
            ),
          ],
        ),
      ],
    );
  }
}
