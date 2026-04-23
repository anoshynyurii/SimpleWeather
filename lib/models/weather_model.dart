class MainWeatherModel {
  final double latitude;
  final double longitude;
  final int utcOffsetSeconds;
  final String timezone;
  final HourlyUnits hourlyUnits;
  final HourlyData hourly;
  final DailyUnits dailyUnits;
  final DailyData daily;

  MainWeatherModel({
    required this.latitude,
    required this.longitude,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  factory MainWeatherModel.fromMap(Map<String, dynamic> map) {
    return MainWeatherModel(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      utcOffsetSeconds: (map['utc_offset_seconds'] as num).toInt(),
      timezone: map['timezone'] as String,
      hourlyUnits: HourlyUnits.fromMap(
        map['hourly_units'] as Map<String, dynamic>,
      ),
      hourly: HourlyData.fromMap(map['hourly'] as Map<String, dynamic>),
      dailyUnits: DailyUnits.fromMap(
        map['daily_units'] as Map<String, dynamic>,
      ),
      daily: DailyData.fromMap(map['daily'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'hourly_units': hourlyUnits.toMap(),
      'hourly': hourly.toMap(),
      'daily_units': dailyUnits.toMap(),
      'daily': daily.toMap(),
    };
  }

  MainWeatherModel copyWith({
    double? latitude,
    double? longitude,
    int? utcOffsetSeconds,
    String? timezone,
    HourlyUnits? hourlyUnits,
    HourlyData? hourly,
    DailyUnits? dailyUnits,
    DailyData? daily,
  }) {
    return MainWeatherModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      timezone: timezone ?? this.timezone,
      hourlyUnits: hourlyUnits ?? this.hourlyUnits,
      hourly: hourly ?? this.hourly,
      dailyUnits: dailyUnits ?? this.dailyUnits,
      daily: daily ?? this.daily,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainWeatherModel &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.utcOffsetSeconds == utcOffsetSeconds &&
        other.timezone == timezone &&
        other.hourlyUnits == hourlyUnits &&
        other.hourly == hourly &&
        other.dailyUnits == dailyUnits &&
        other.daily == daily;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        utcOffsetSeconds.hashCode ^
        timezone.hashCode ^
        hourlyUnits.hashCode ^
        hourly.hashCode ^
        dailyUnits.hashCode ^
        daily.hashCode;
  }
}

class HourlyUnits {
  final String time;
  final String temp2m;
  final String precProb;
  final String wmo;
  final String windSpeed10m;

  HourlyUnits({
    required this.time,
    required this.temp2m,
    required this.precProb,
    required this.wmo,
    required this.windSpeed10m,
  });

  factory HourlyUnits.fromMap(Map<String, dynamic> map) {
    return HourlyUnits(
      time: map['time'] as String,
      temp2m: map['temperature_2m'] as String,
      precProb: map['precipitation_probability'] as String,
      wmo: map['weather_code'] as String,
      windSpeed10m: map['wind_speed_10m'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature_2m': temp2m,
      'precipitation_probability': precProb,
      'weather_code': wmo,
      'wind_speed_10m': windSpeed10m,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HourlyUnits &&
        other.time == time &&
        other.temp2m == temp2m &&
        other.precProb == precProb &&
        other.wmo == wmo &&
        other.windSpeed10m == windSpeed10m;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        temp2m.hashCode ^
        precProb.hashCode ^
        wmo.hashCode ^
        windSpeed10m.hashCode;
  }
}

class HourlyData {
  final List<String> time;
  final List<double> temp2m;
  final List<int> precProb;
  final List<int> wmo;
  final List<double> windSpeed10m;

  HourlyData({
    required this.time,
    required this.temp2m,
    required this.precProb,
    required this.wmo,
    required this.windSpeed10m,
  });

  factory HourlyData.fromMap(Map<String, dynamic> map) {
    return HourlyData(
      time: List<String>.from(map['time'] ?? []),
      temp2m:
          (map['temperature_2m'] as List?)
              ?.map((e) => e == null ? 0.0 : (e as num).toDouble())
              .toList() ??
          [],
      precProb:
          (map['precipitation_probability'] as List?)
              ?.map((e) => e == null ? 0 : (e as num).toInt())
              .toList() ??
          [],
      wmo:
          (map['weather_code'] as List?)
              ?.map((e) => e == null ? 0 : (e as num).toInt())
              .toList() ??
          [],
      windSpeed10m:
          (map['wind_speed_10m'] as List?)
              ?.map((e) => e == null ? 0.0 : (e as num).toDouble())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature_2m': temp2m,
      'precipitation_probability': precProb,
      'weather_code': wmo,
      'wind_speed_10m': windSpeed10m,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HourlyData &&
        other.time == time &&
        other.temp2m == temp2m &&
        other.precProb == precProb &&
        other.wmo == wmo &&
        other.windSpeed10m == windSpeed10m;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        temp2m.hashCode ^
        precProb.hashCode ^
        wmo.hashCode ^
        windSpeed10m.hashCode;
  }
}

class DailyUnits {
  final String time;
  final String temp2mMin;
  final String temp2mMax;
  final String windSpeed10mMax;
  final String wmo;

  DailyUnits({
    required this.time,
    required this.temp2mMin,
    required this.temp2mMax,
    required this.windSpeed10mMax,
    required this.wmo,
  });

  factory DailyUnits.fromMap(Map<String, dynamic> map) {
    return DailyUnits(
      time: map['time'] as String,
      temp2mMin: map['temperature_2m_min'] as String,
      temp2mMax: map['temperature_2m_max'] as String,
      windSpeed10mMax: map['wind_speed_10m_max'] as String,
      wmo: map['weather_code'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature_2m_min': temp2mMin,
      'temperature_2m_max': temp2mMax,
      'wind_speed_10m_max': windSpeed10mMax,
      'weather_code': wmo,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyUnits &&
        other.time == time &&
        other.temp2mMin == temp2mMin &&
        other.temp2mMax == temp2mMax &&
        other.windSpeed10mMax == windSpeed10mMax &&
        other.wmo == wmo;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        temp2mMin.hashCode ^
        temp2mMax.hashCode ^
        windSpeed10mMax.hashCode ^
        wmo.hashCode;
  }
}

class DailyData {
  final List<String> time;
  final List<double> temp2mMin;
  final List<double> temp2mMax;
  final List<double> windSpeed10mMax;
  final List<int> wmo;

  DailyData({
    required this.time,
    required this.temp2mMin,
    required this.temp2mMax,
    required this.windSpeed10mMax,
    required this.wmo,
  });

  factory DailyData.fromMap(Map<String, dynamic> map) {
    return DailyData(
      time: List<String>.from(map['time'] ?? []),
      temp2mMin: (map['temperature_2m_min'] as List?)
              ?.map((e) => e == null ? 0.0 : (e as num).toDouble())
              .toList() ??
          [],
      temp2mMax: (map['temperature_2m_max'] as List?)
              ?.map((e) => e == null ? 0.0 : (e as num).toDouble())
              .toList() ??
          [],
      windSpeed10mMax: (map['wind_speed_10m_max'] as List?)
              ?.map((e) => e == null ? 0.0 : (e as num).toDouble())
              .toList() ??
          [],
      wmo: (map['weather_code'] as List?)
              ?.map((e) => e == null ? 0 : (e as num).toInt())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature_2m_min': temp2mMin,
      'temperature_2m_max': temp2mMax,
      'wind_speed_10m_max': windSpeed10mMax,
      'weather_code': wmo,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyData &&
        other.time == time &&
        other.temp2mMin == temp2mMin &&
        other.temp2mMax == temp2mMax &&
        other.windSpeed10mMax == windSpeed10mMax &&
        other.wmo == wmo;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        temp2mMin.hashCode ^
        temp2mMax.hashCode ^
        windSpeed10mMax.hashCode ^
        wmo.hashCode;
  }
}

