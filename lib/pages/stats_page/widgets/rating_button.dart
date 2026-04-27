import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';

class RatingButton extends StatelessWidget {
  const RatingButton({
    super.key,
    required this.cityName,
    required this.context,
    required this.rating,
    required this.color,
    required this.label,
  });

  final String cityName;
  final BuildContext context;
  final int rating;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final currentHour = DateTime.now().hour;
            if (currentHour > 19) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Оцінити прогноз можна лише після 19:00'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }

            final errorMessage = await context.read<WeatherCubit>().sendRating(
              rating,
            );

            if (errorMessage != null) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 3),
                ),
              );
            } else {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Оцінка $rating для $cityName надіслана!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
            backgroundColor: color.withAlpha(60),
            foregroundColor: color,
            elevation: 0,
          ),
          child: Text(
            rating.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
