import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:simple_weather/models/stats_model.dart';

class StatsRepo {
  final Dio dio;
  static const String _scriptUrl = String.fromEnvironment('SCRIPT_URL');

  StatsRepo(this.dio);

  Future<StatsModel> getStats(String userId) async {

    final response = await dio.get(
      _scriptUrl,
      queryParameters: {'userId': userId},
    );
    return StatsModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> sendRating({
    required String userId,
    required String city,
    required int rating,
  }) async {
    await dio.post(
      _scriptUrl,
      data: jsonEncode({
        'action': 'rate',
        'userId': userId,
        'city': city,
        'rating': rating,
      }),
      options: Options(contentType: Headers.textPlainContentType)
    );
  }
}
