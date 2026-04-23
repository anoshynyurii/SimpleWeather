import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/models/city_model.dart';
import 'package:simple_weather/models/stats_model.dart';
import 'package:simple_weather/repositories/dio_repo.dart';
import 'package:simple_weather/repositories/local_repo.dart';
import 'package:simple_weather/repositories/auth_repo.dart';
import 'package:simple_weather/repositories/stats_repo.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo weatherRepo;
  final GeoRepo geoRepo;
  final CityRepo cityRepo;
  final AuthRepo authRepo;
  final StatsRepo statsRepo;
  Timer? _debounce;

  WeatherCubit({
    required this.weatherRepo,
    required this.geoRepo,
    required this.cityRepo,
    required this.authRepo,
    required this.statsRepo,
  }) : super(const WeatherInitial());

  Future<void> init() async {
    emit(const WeatherLoading(isInitLoading: true));

    final savedCity = cityRepo.getSavedCity();
    final tId = await authRepo.getTelegramId();

    StatsModel? stats;

    if (tId != null && tId.isNotEmpty) {
      try {
        stats = await statsRepo.getStats(tId);
      } catch (_) {}
    }

    if (savedCity != null) {
      try {
        final weather = await weatherRepo.getResponse(
          savedCity.latitude,
          savedCity.longitude,
        );

        emit(
          WeatherLoaded(
            weather: weather,
            selectedCity: savedCity,
            telegramId: tId,
            stats: stats,
            isInitLoading: false,
          ),
        );
      } catch (e) {
        emit(
          WeatherError(
            'Помилка: $e',
            telegramId: tId,
            stats: stats,
            isInitLoading: false,
          ),
        );
      }
    } else {
      emit(
        WeatherInitial(
          telegramId: tId,
          stats: stats,
          isInitLoading: false,
        ),
      );
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.length < 2) {
      _updateResults([]);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final cities = await geoRepo.searchCity(query);
        _updateResults(cities);
      } catch (_) {
        _updateResults([]);
      }
    });
  }

  void _updateResults(List<CityModel> cities) {
    final s = state;

    if (s is WeatherLoaded) {
      emit(s.copyWith(searchResults: cities));
    } else if (s is WeatherInitial) {
      emit(
        WeatherInitial(
          searchResults: cities,
          telegramId: s.telegramId,
          stats: s.stats,
          isInitLoading: s.isInitLoading,
        ),
      );
    } else if (s is WeatherLoading) {
      emit(
        WeatherLoading(
          searchResults: cities,
          telegramId: s.telegramId,
          stats: s.stats,
          isInitLoading: s.isInitLoading,
        ),
      );
    } else if (s is WeatherError) {
      emit(
        WeatherError(
          s.message,
          searchResults: cities,
          telegramId: s.telegramId,
          stats: s.stats,
          isInitLoading: s.isInitLoading,
        ),
      );
    }
  }

  Future<void> fetchWeather(CityModel city) async {
    final id = state.telegramId;
    final stats = state.stats;

    emit(
      WeatherLoading(
        telegramId: id,
        stats: stats,
        isInitLoading: false,
      ),
    );

    try {
      final weather = await weatherRepo.getResponse(
        city.latitude,
        city.longitude,
      );

      cityRepo.saveCity(city);

      emit(
        WeatherLoaded(
          weather: weather,
          selectedCity: city,
          telegramId: id,
          stats: stats,
          isInitLoading: false,
        ),
      );
    } catch (e) {
      emit(
        WeatherError(
          'Помилка: $e',
          telegramId: id,
          stats: stats,
          isInitLoading: false,
        ),
      );
    }
  }

  Future<void> saveTelegramId(String id) async {
    if (id.isEmpty) return;

    await authRepo.saveTelegramId(id);

    try {
      final stats = await statsRepo.getStats(id);
      final s = state;
      if (s is WeatherLoaded) {
        emit(s.copyWith(telegramId: id, stats: stats));
      } else {
        emit(
          WeatherInitial(telegramId: id, stats: stats, isInitLoading: false),
        );
        final savedCity = cityRepo.getSavedCity();
        if (savedCity != null) {
          await fetchWeather(savedCity);
        }
      }
    } catch (e) {
      final s = state;
      if (s is WeatherLoaded) {
        emit(s.copyWith(telegramId: id));
      } else {
        emit(WeatherInitial(telegramId: id, isInitLoading: false));
        final savedCity = cityRepo.getSavedCity();
        if (savedCity != null) {
          await fetchWeather(savedCity);
        }
      }
    }
  }

  Future<String?> sendRating(int rating) async {
    final s = state;

    if (s is! WeatherLoaded || s.telegramId == null || s.telegramId!.isEmpty) {
      return 'Помилка. Спробуйте пізніше.';
    }

    final canRate = await authRepo.canRateToday();
    if (!canRate) {
      return 'Ви вже залишали оцінку сьогодні! Дякуємо 🌤';
    }

    emit(
      s.copyWith(isRatingLoading: true),
    );

    try {
      try {
        await statsRepo.sendRating(
          userId: s.telegramId!,
          city: s.selectedCity.name,
          rating: rating,
        );
      } catch (_) {
      }
      await authRepo.saveLastRatingDate();
      final updatedStats = await statsRepo.getStats(s.telegramId!);
      emit(
        s.copyWith(
          stats: updatedStats,
          isRatingLoading: false,
        ),
      );

      return null; 
    } catch (_) {
      emit(
        s.copyWith(isRatingLoading: false),
      );
      return 'Помилка при оновленні статистики';
    }
  }

  Future<void> logout() async {
    await authRepo.saveTelegramId('');
    emit(const WeatherInitial(isInitLoading: false));
  }
}
