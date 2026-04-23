import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:simple_weather/models/weather_model.dart';
import 'package:simple_weather/utils/weather_translator.dart';

class PdfService {
  static Future<void> generateAndOpenPdf(
    MainWeatherModel weather,
    String cityName,
  ) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assets/Inter-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: ttf,
          bold: ttf,
        ),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Прогноз погоди: $cityName',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                context: context,
                headers: ['Дата', 'Мін. темп', 'Макс. темп', 'Вітер', 'Стан'],
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                data: List.generate(7, (index) {
                  final date = DateTime.parse(weather.daily.time[index]);
                  final dateString =
                      '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}';
                  final minT = '${weather.daily.temp2mMin[index].round()}°C';
                  final maxT = '${weather.daily.temp2mMax[index].round()}°C';
                  final wind = '${weather.daily.windSpeed10mMax[index]} км/год';
                  final desc = WeatherTranslator.getWeatherDescription(
                    weather.daily.wmo[index],
                  );

                  return [dateString, minT, maxT, wind, desc];
                }),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/weather_$cityName.pdf');
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }
}
