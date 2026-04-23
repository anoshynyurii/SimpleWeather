class CityModel {
  final String name;
  final double latitude;
  final double longitude;
  final String? oblast;
  final String countryCode;

  CityModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    this.oblast,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] as String? ?? 'Невідомо',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      countryCode: map['country_code'] as String? ?? 'UA',
      oblast: map['admin1'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'admin1': oblast,
    'country_code': countryCode,
  };
}
