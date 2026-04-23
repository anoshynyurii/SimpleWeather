import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/pages/home_page/widgets/daily_forecast.dart';
import 'package:simple_weather/pages/home_page/widgets/search_field.dart';
import 'package:simple_weather/pages/home_page/widgets/weather_today.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Прогноз погоди')),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            final cubit = context.read<WeatherCubit>();
            final currentResults = state.searchResults;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchField(
                    value: state is WeatherLoaded
                        ? state.selectedCity.name
                        : '',
                    onChanged: cubit.onSearchChanged,
                    onClear: () {
                      cubit.onSearchChanged('');
                    },
                  ),

                  if (currentResults.isNotEmpty)
                    SearchResultsList(
                      cities: currentResults,
                      onSelect: (city) {
                        FocusScope.of(context).unfocus();
                        context.read<WeatherCubit>().fetchWeather(city);
                        context.read<WeatherCubit>().onSearchChanged('');
                        
                      },
                    ),

                  const SizedBox(height: 24),

                  if (state is WeatherLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state is WeatherLoaded)
                    WeatherContent(state: state)
                  else if (state is WeatherError)
                  Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(maxLines: 1,'Будь ласка, оберіть місто 🇺🇦', style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    super.key,
    required this.state,
  });

  final WeatherLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherToday(
          weather: state.weather,
          cityName: state.selectedCity.name,
        ),
        const SizedBox(height: 30),
        DailyForecastList(weather: state.weather),
      ],
    );
  }
}
