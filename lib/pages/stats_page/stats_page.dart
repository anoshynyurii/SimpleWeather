import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/pages/stats_page/widgets/auth_widget.dart';
import 'package:simple_weather/pages/stats_page/widgets/stats_content_widget.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state.isInitLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.telegramId == null || state.telegramId!.isEmpty) {
            return const AuthWidget();
          }

          if (state.stats == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return StatsContentWidget(
            stats: state.stats!,
            hasSelectedCity: state is WeatherLoaded,
            currentCityName: state is WeatherLoaded
                ? state.selectedCity.name
                : null,
          );
        },
      ),
    );
  }
}
