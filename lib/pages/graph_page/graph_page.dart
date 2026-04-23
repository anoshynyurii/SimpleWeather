import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/pages/graph_page/widgets/weather_chart.dart';
import 'package:simple_weather/theme/theme.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  bool _showTemperature = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Графіки')),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is! WeatherLoaded) {
            return const Center(
              child: Text(
                'Будь ласка, оберіть місто на головній сторінці',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final weather = state.weather;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.containers,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: WeatherChart(
                      weather: weather,
                      showTemperature: _showTemperature,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                WeatherSwitchControl(
                  showTemperature: _showTemperature,
                  onChanged: (value) {
                    setState(() {
                      _showTemperature = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WeatherSwitchControl extends StatelessWidget {
  final bool showTemperature;
  final ValueChanged<bool> onChanged;

  const WeatherSwitchControl({
    super.key,
    required this.showTemperature,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.wind_power,
          size: 40,
          color: AppColors.tempMinusTen,
        ),
        const SizedBox(width: 12),
        Switch(
          value: showTemperature,
          activeThumbColor: AppColors.tempPlusTen,
          inactiveThumbColor: AppColors.tempMinusTen,
          activeTrackColor: AppColors.containers,
          inactiveTrackColor: AppColors.containers,
          onChanged: onChanged,
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.thermostat,
          size: 40,
          color: AppColors.tempPlusTen,
        ),
      ],
    );
  }
}
