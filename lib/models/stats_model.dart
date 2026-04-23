class StatsModel {
  final String userId;
  final int totalVotes;
  final double averageRating;
  final int successPercentage;
  final Map<String, int> cities;

  StatsModel({
    required this.userId,
    required this.totalVotes,
    required this.averageRating,
    required this.successPercentage,
    required this.cities,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> citiesJson = json['cities'] ?? {};
    final Map<String, int> parsedCities = {};

    citiesJson.forEach((key, value) {
      parsedCities[key] = (value as num).toInt();
    });

    return StatsModel(
      userId: json['userId']?.toString() ?? '',
      totalVotes: int.tryParse(json['totalVotes']?.toString() ?? '0') ?? 0,
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '0.0') ?? 0.0,
      successPercentage:
          int.tryParse(json['successPercentage']?.toString() ?? '0') ?? 0,
      cities: parsedCities,
    );
  }
}
