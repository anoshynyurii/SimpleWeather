import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/theme_cubit/theme_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/repositories/auth_repo.dart';
import 'package:simple_weather/repositories/dio_repo.dart';
import 'package:simple_weather/repositories/local_repo.dart';
import 'package:simple_weather/repositories/stats_repo.dart';
import 'package:simple_weather/services/di/di.dart';
import 'package:simple_weather/services/routes/app_routes.dart';
import 'package:simple_weather/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getIt<ThemeRepo>()),
        RepositoryProvider.value(value: getIt<CityRepo>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(context.read<ThemeRepo>()),
            
          ),
          BlocProvider(
            lazy: false,
            create: (context) => WeatherCubit(
              weatherRepo: getIt<WeatherRepo>(),
              geoRepo: getIt<GeoRepo>(),
              cityRepo: getIt<CityRepo>(),
              authRepo: getIt<AuthRepo>(),
              statsRepo: getIt<StatsRepo>(),
            )..init(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.mode == ThemeModeEnum.system
                  ? ThemeMode.system
                  : state.mode == ThemeModeEnum.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
