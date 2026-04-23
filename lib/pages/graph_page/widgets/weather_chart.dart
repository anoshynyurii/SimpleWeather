import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather/models/weather_model.dart';
import 'package:simple_weather/theme/theme.dart';
import 'package:simple_weather/utils/weather_translator.dart';

class WeatherChart extends StatelessWidget {
  final MainWeatherModel weather;
  final bool showTemperature;

  const WeatherChart({
    super.key,
    required this.weather,
    required this.showTemperature,
  });

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = [];

    for (int i = 0; i < 7; i++) {
      final yValue = showTemperature
          ? weather.daily.temp2mMax[i].roundToDouble()
          : weather.daily.windSpeed10mMax[i].roundToDouble();
      spots.add(FlSpot(i.toDouble(), yValue));
    }

    double exactMinY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    double exactMaxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);

    double range = exactMaxY - exactMinY;
    if (range == 0) range = 1;

    double minY = exactMinY - (range * 0.1);
    double maxY = exactMaxY + (range * 0.2);

    double rangeY = maxY - minY;

    final tempValues = [-30.0, -20.0, -10.0, 0.0, 10.0, 20.0, 30.0];
    final gradientStops = tempValues
        .map((t) => ((t - minY) / rangeY).clamp(0.0, 1.0))
        .toList();

    final lineBarData = LineChartBarData(
      spots: spots,
      isCurved: true,
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      color: showTemperature ? null : AppColors.primaryColor,
      gradient: showTemperature
          ? LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: gradientStops,
              colors: [
                AppColors.tempMinusMax,
                AppColors.tempMinusTwenty,
                AppColors.tempMinusTen,
                AppColors.tempZero,
                AppColors.tempPlusTen,
                AppColors.tempPlusTwenty,
                AppColors.tempPlusMax,
              ],
            )
          : null,
      dotData: const FlDotData(show: false),
      showingIndicators: spots.asMap().keys.toList(),
    );

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: minY,
        maxY: maxY,
        gridData: const FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value > 6 || value % 1 != 0) {
                  return const SizedBox.shrink();
                }
                final date = DateTime.parse(weather.daily.time[value.toInt()]);
                const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Нд'];
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    maxLines: 1,
                    days[date.weekday - 1],
                    style: const TextStyle(
                      color: AppColors.darkThemeText,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [lineBarData],
        showingTooltipIndicators: spots.asMap().entries.map((entry) {
          return ShowingTooltipIndicators([
            LineBarSpot(lineBarData, 0, entry.value),
          ]);
        }).toList(),
        lineTouchData: LineTouchData(
          enabled: false,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return const TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.transparent,
                  strokeWidth: 0,
                ),
                FlDotData(show: false),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.transparent,
            tooltipPadding: EdgeInsets.only(bottom: 0),
            tooltipHorizontalOffset: 4,

            tooltipHorizontalAlignment: FLHorizontalAlignment.center,
            tooltipMargin: 40,
            tooltipBorder: BorderSide.none,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toInt()}${showTemperature ? '°' : ''}',
                  TextStyle(
                    color: showTemperature
                        ? WeatherTranslator.getTempColor(spot.y)
                        : AppColors.darkThemeText,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
