import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/models/stats_model.dart';
import 'package:simple_weather/pages/stats_page/widgets/city_stats_list_widget.dart';
import 'package:simple_weather/pages/stats_page/widgets/rating_widget.dart';
import 'package:simple_weather/pages/stats_page/widgets/stats_card_widget.dart';
import 'package:simple_weather/theme/theme.dart';

class StatsContentWidget extends StatefulWidget {
  final StatsModel stats;
  final bool hasSelectedCity;
  final String? currentCityName;

  const StatsContentWidget({
    super.key,
    required this.stats,
    required this.hasSelectedCity,
    this.currentCityName,
  });

  @override
  State<StatsContentWidget> createState() => _StatsContentWidgetState();
}

class _StatsContentWidgetState extends State<StatsContentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final isLoading = state.isRatingLoading;

        return Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (widget.hasSelectedCity) ...[
                  RatingWidget(cityName: widget.currentCityName!),
                  const Divider(height: 48, thickness: 2),
                ],
                if (!widget.hasSelectedCity) ...[
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Оберіть місто на головному екрані, щоб залишити оцінку.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                StatsCardWidget(
                  title: 'Усього оцінок',
                  value: widget.stats.totalVotes.toString(),
                ),
                const SizedBox(height: 12),
                StatsCardWidget(
                  title: 'Середня оцінка',
                  value: widget.stats.averageRating.toString(),
                ),
                const SizedBox(height: 12),
                StatsCardWidget(
                  title: 'Точність прогнозів',
                  value: '${widget.stats.successPercentage}%',
                ),
                const SizedBox(height: 24),
                const Text(
                  'Оцінені міста:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                CityStatsListWidget(cities: widget.stats.cities),
                const SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            await context.read<WeatherCubit>().logout();
                          },
                    child: const Text(
                      'Вийти',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),

            if (isLoading)
              Container(
                color: AppColors.primaryColor.withAlpha(50),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
