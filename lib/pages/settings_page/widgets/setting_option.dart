import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/bloc/theme_cubit/theme_cubit.dart';
import 'package:simple_weather/theme/theme.dart';

class SettingOption extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback? onTap;
  final bool switchTheme;

  const SettingOption({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
    this.switchTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.mode == ThemeModeEnum.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 80,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          spacing: 8,
          children: [
            Icon(
              icon,
              size: 26,
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (switchTheme)
              Switch(
                padding: EdgeInsets.zero,
                value: isDark,
                onChanged: (_) {
                  context.read<ThemeCubit>().changeTheme();
                },
                activeThumbColor: AppColors.buttons,
                inactiveThumbColor: AppColors.buttons,
                activeTrackColor: AppColors.bars,
                inactiveTrackColor: AppColors.bars,
              )
            else
              Icon(
                Icons.arrow_forward_ios_outlined,
              ),
          ],
        ),
      ),
    );
  }
}
