import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_weather/repositories/auth_repo.dart';
import 'package:simple_weather/repositories/local_repo.dart';
import 'package:simple_weather/repositories/dio_repo.dart';
import 'package:simple_weather/repositories/stats_repo.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final themeRepo = ThemeRepo();
  await themeRepo.init();

  final cityRepo = CityRepo();
  await cityRepo.init();

  const secureStorage = FlutterSecureStorage();
  final authRepo = AuthRepo(secureStorage);
  await authRepo.init();

  getIt.registerSingleton<ThemeRepo>(themeRepo);
  getIt.registerSingleton<CityRepo>(cityRepo);
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);
  getIt.registerSingleton<AuthRepo>(authRepo);
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerLazySingleton<StatsRepo>(() => StatsRepo(getIt<Dio>()));
  getIt.registerLazySingleton<WeatherRepo>(() => WeatherRepo(getIt<Dio>()));
  getIt.registerLazySingleton<GeoRepo>(() => GeoRepo(getIt<Dio>()));
}
