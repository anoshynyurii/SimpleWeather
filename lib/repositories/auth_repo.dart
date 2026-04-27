import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepo {
  final FlutterSecureStorage _storage;

  String? _telegramId;
  String? _lastRatingDate;

  AuthRepo(this._storage);

  Future<void> init() async {
    _telegramId = await _storage.read(key: 'telegram_id');
    _lastRatingDate = await _storage.read(key: 'last_rating_date');
  }

  void saveTelegramId(String id) {
    _telegramId = id;
    _storage.write(key: 'telegram_id', value: id);
  }

  String? getTelegramId() {
    return _telegramId;
  }

  void saveLastRatingDate() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    _lastRatingDate = today;
    _storage.write(key: 'last_rating_date', value: today);
  }

  bool canRateToday() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return today != _lastRatingDate;
  }
}
