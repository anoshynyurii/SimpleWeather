import 'package:flutter/material.dart';

enum ThemeModeEnum { light, dark, system }

class AppTheme {
  static final NavigationBarThemeData navigationBarTheme =
      NavigationBarThemeData(
        backgroundColor: AppColors.bars,
        height: 90,
        elevation: 0,
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            size: states.contains(WidgetState.selected) ? 28 : 34,
            color: AppColors.darkThemeText,
          );
        }),
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkThemeText,
            letterSpacing: 1,
          ),
        ),
      );

  static final ProgressIndicatorThemeData progressIndicatorTheme =
      ProgressIndicatorThemeData(
        circularTrackColor: AppColors.primaryColor,
      );

  static final SnackBarThemeData snackBarThemeData = SnackBarThemeData(
    actionBackgroundColor: AppColors.bars,
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightScaffold,
    focusColor: AppColors.lightThemeText,
    useMaterial3: true,
    dividerTheme: DividerThemeData(
      color: AppColors.primaryColor.withAlpha(150),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.bars,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: AppColors.darkThemeText,
        letterSpacing: 2,
      ),
    ),
    navigationBarTheme: navigationBarTheme,
  );


  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkScaffold,
    focusColor: AppColors.darkThemeText,
    useMaterial3: true,
    dividerTheme: DividerThemeData(
      color: AppColors.primaryColor.withAlpha(150),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.bars,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: AppColors.darkThemeText,
        letterSpacing: 2,
      ),
    ),
    navigationBarTheme: navigationBarTheme,
  );
}

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color.fromRGBO(119, 212, 255, 1);

  static Color lightScaffold = Colors.blue.shade50;
  static Color darkScaffold = Colors.blueGrey.shade900;

  static Color bars = Colors.blueGrey.shade500;

  static Color lightThemeText = Colors.blueGrey.shade900;
  static const Color darkThemeText = Colors.white;

  static Color buttons = Colors.blue.shade200;
  static Color borders = Colors.blueGrey.shade600;
  static Color containers = Colors.blueGrey.shade400;

  static Color tempPlusTen = Colors.amber.shade400;
  static Color tempPlusTwenty = Colors.amber.shade700;
  static Color tempPlusMax = Colors.amber.shade900;
  static Color tempZero = Colors.cyan.shade100;
  static Color tempMinusTen = Colors.cyan.shade300;
  static Color tempMinusTwenty = Colors.cyan.shade500;
  static Color tempMinusMax = Colors.cyan.shade700;
}
