import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyNewUser = 'newUser';
  static const _keyOtp = 'otp';
  static const _keyUserId = 'userId';
  static const _expiryTime = 'expiryTime';
  static const _isRegistering = 'isRegistering';

  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future deleteSecureStorage() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyNewUser);
  }

  static Future setNewUser(String newUser) async {
    await _storage.write(key: _keyNewUser, value: newUser);
  }

  static Future<String?> fetchNewUser() async {
    return await _storage.read(key: _keyNewUser);
  }

  static Future setOtp(String otp) async {
    await _storage.write(key: _keyOtp, value: otp);
  }

  static Future<String?> fetchOtp() async {
    return await _storage.read(key: _keyOtp);
  }

  static Future deleteOtp() async {
    await _storage.delete(key: _keyOtp);
  }

  static Future setUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  static Future<String?> fetchUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  static Future setExpiryTime(String expiryTime) async {
    await _storage.write(key: _expiryTime, value: expiryTime);
  }

  static Future<String?> fetchExpiryTime() async {
    return await _storage.read(key: _expiryTime);
  }

  static Future setIsRegistering(String isRegistering) async {
    await _storage.write(key: _isRegistering, value: isRegistering);
  }

  static Future<String?> fetchIsRegistering() async {
    return await _storage.read(key: _isRegistering);
  }

  static Future deleteIsRegistering() async {
    await _storage.delete(key: _isRegistering);
  }
}
