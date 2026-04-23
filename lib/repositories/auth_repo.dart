import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepo {
  final FlutterSecureStorage _storage;

  AuthRepo(this._storage);

  Future<void> saveTelegramId(String id) async {
    await _storage.write(key: 'telegram_id', value: id);
  }

  Future<String?> getTelegramId() async {
    return await _storage.read(key: 'telegram_id');
  }

  Future<void> saveLastRatingDate() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    await _storage.write(key: 'last_rating_date', value: today);
  }

  Future<bool> canRateToday() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final lastDate = await _storage.read(key: 'last_rating_date');
    return today != lastDate; 
  }
}
