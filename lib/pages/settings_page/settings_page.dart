import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/theme_cubit/theme_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_state.dart';
import 'package:simple_weather/pages/settings_page/widgets/setting_option.dart';
import 'package:simple_weather/services/pdf/pdf_service.dart';
import 'package:simple_weather/theme/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state.mode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          SettingOption(
            name: 'Тема',
            switchTheme: true,
            onTap: () => context.read<ThemeCubit>().changeTheme(),
            icon: themeMode == ThemeModeEnum.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          if (!kIsWeb)
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  return SettingOption(
                    name: 'Завантажити прогноз на тиждень',
                    icon: Icons.picture_as_pdf,
                    onTap: () {
                      PdfService.generateAndOpenPdf(
                        state.weather,
                        state.selectedCity.name,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
