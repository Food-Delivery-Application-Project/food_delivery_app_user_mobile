import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _isRegistering = 'isRegistering';

  static Future<void> setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  static Future<void> setIsRegistering(String value) async {
    await _storage.write(key: _isRegistering, value: value);
  }

  static Future<String?> fetchIsRegistering() async {
    return await _storage.read(key: _isRegistering);
  }

  static Future<void> deleteIsRegistering() async {
    await _storage.delete(key: _isRegistering);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
