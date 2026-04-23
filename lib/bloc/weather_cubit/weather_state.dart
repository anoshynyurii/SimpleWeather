import 'package:simple_weather/models/city_model.dart';
import 'package:simple_weather/models/weather_model.dart';
import 'package:simple_weather/models/stats_model.dart';

abstract class WeatherState {
  final List<CityModel> searchResults;
  final String? telegramId;
  final StatsModel? stats;
  final bool isInitLoading;
  final bool isRatingLoading;

  const WeatherState({
    this.searchResults = const [],
    this.telegramId,
    this.stats,
    this.isInitLoading = false,
    this.isRatingLoading = false,
  });
}

class WeatherInitial extends WeatherState {
  const WeatherInitial({
    super.searchResults,
    super.telegramId,
    super.stats,
    super.isInitLoading,
    super.isRatingLoading,
  });
}

class WeatherLoading extends WeatherState {
  const WeatherLoading({
    super.searchResults,
    super.telegramId,
    super.stats,
    super.isInitLoading,
    super.isRatingLoading,
  });
}

class WeatherLoaded extends WeatherState {
  final MainWeatherModel weather;
  final CityModel selectedCity;

  const WeatherLoaded({
    required this.weather,
    required this.selectedCity,
    super.searchResults,
    super.telegramId,
    super.stats,
    super.isInitLoading,
    super.isRatingLoading,
  });

  WeatherLoaded copyWith({
    MainWeatherModel? weather,
    CityModel? selectedCity,
    List<CityModel>? searchResults,
    String? telegramId,
    StatsModel? stats,
    bool? isRatingLoading,
  }) {
    return WeatherLoaded(
      weather: weather ?? this.weather,
      selectedCity: selectedCity ?? this.selectedCity,
      searchResults: searchResults ?? this.searchResults,
      telegramId: telegramId ?? this.telegramId,
      stats: stats ?? this.stats,
      isInitLoading: isInitLoading,
      isRatingLoading: isRatingLoading ?? this.isRatingLoading,
    );
  }
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(
    this.message, {
    super.searchResults,
    super.telegramId,
    super.stats,
    super.isInitLoading,
    super.isRatingLoading,
  });
}
