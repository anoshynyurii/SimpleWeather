import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/weather_cubit/weather_cubit.dart';
import 'package:simple_weather/theme/theme.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  String _inputId = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.telegram, size: 100, color: Colors.blue),
            const SizedBox(height: 30),
            const Text(
              'Введіть ваш Telegram ID',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Отримати його можна у бота \n @SimpleWeatherStats_bot',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Telegram ID',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              onChanged: (value) {
                _inputId = value;
              },
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_inputId.isEmpty) return;

                      setState(() => _isLoading = true);

                      final errorMessage = await context
                          .read<WeatherCubit>()
                          .saveTelegramId(
                            _inputId,
                          );

                      if (!mounted) return;

                      setState(() => _isLoading = false);

                      if (errorMessage != null) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red.shade400,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      'Увійти',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.containers,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
