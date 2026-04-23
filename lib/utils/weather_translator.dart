import 'package:flutter/material.dart';
import 'package:simple_weather/theme/theme.dart';

class WeatherTranslator {
  static IconData getWeatherIcon(int weatherStatus) {
    if (weatherStatus == 0 || weatherStatus == 1) return Icons.wb_sunny_rounded;
    if (weatherStatus == 2 || weatherStatus == 3) {
      return Icons.wb_cloudy_rounded;
    }
    if (weatherStatus == 45 || weatherStatus == 48) return Icons.foggy;
    if (weatherStatus <= 51 || weatherStatus <= 86) return Icons.cloudy_snowing;
    if (weatherStatus == 95 || weatherStatus == 96 || weatherStatus == 99) {
      return Icons.thunderstorm;
    }
    return Icons.report_problem_rounded;
  }

  static String getWeatherDescription(int weatherStatus) {
    if (weatherStatus == 0) {
      return 'Ясне небо';
    }
    if (weatherStatus == 1) {
      return 'Переважно ясно';
    }
    if (weatherStatus == 2 || weatherStatus == 3) {
      return 'Частково хмарно';
    }
    if (weatherStatus == 45 || weatherStatus == 48) {
      return 'Туман';
    }
    if (weatherStatus == 51 || weatherStatus == 53 || weatherStatus == 55) {
      return "${weatherStatus == 51 ? "Легка" : "Помірна"} Мряка";
    }
    if (weatherStatus == 56 || weatherStatus == 57) {
      return 'Мокрий Сніг';
    }
    if (weatherStatus == 61 || weatherStatus == 63 || weatherStatus == 65) {
      return "${weatherStatus == 61 ? "Невеликий" : "Сильний"} Дощ";
    }
    if (weatherStatus == 66 || weatherStatus == 67) {
      return "${weatherStatus == 66 ? "Невеликий" : "Сильний"} Дощ зі снігом";
    }
    if (weatherStatus == 71 || weatherStatus == 73 || weatherStatus == 75) {
      return "${weatherStatus == 71 ? "Слабкий" : "Сильний"} Сніг";
    }
    if (weatherStatus == 77) {
      return 'Сніжинки';
    }
    if (weatherStatus == 80 || weatherStatus == 81 || weatherStatus == 82) {
      return "${weatherStatus == 80 ? "Слабкі" : "Сильні"} Дощові зливи";
    }
    if (weatherStatus == 85 || weatherStatus == 86) {
      return "${weatherStatus == 85 ? "Слабкі" : "Сильні"} Снігові зливи";
    }
    if (weatherStatus == 95 || weatherStatus == 96 || weatherStatus == 99) {
      return 'Гроза';
    }
    return '';
  }

  static Color getTempColor(double temp) {
    if (temp <= -30) return AppColors.tempMinusMax;
    if (temp <= -20) return AppColors.tempMinusTwenty;
    if (temp <= 0) return AppColors.tempMinusTen;
    if (temp <= 10) return AppColors.tempZero;
    if (temp <= 20) return AppColors.tempPlusTen;
    if (temp <= 30) return AppColors.tempPlusTwenty;
    return AppColors.tempPlusMax;
  }
}



// 0,1 sunny
// 2,3 cloudy
// 45,48 foggy
// 51,53,55,56,57,61,63,65,66,67,80,81,82 rainy
// 71,73, 75, 76, 77, 85,86, snowy
// 95, 96, 99 thunderstorm