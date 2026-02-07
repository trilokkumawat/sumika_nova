import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for auth state in this project only.
/// Use [saveLogin] on sign in and [clear] on logout.
class SecureAuthStorage {
  SecureAuthStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyToken = 'auth_token';

  /// Saves login state (call after successful sign in).
  static Future<void> saveLogin({String? token}) async {
    await _storage.write(
      key: _keyToken,
      value: token ?? DateTime.now().toIso8601String(),
    );
  }

  /// Returns true if user is logged in (token exists).
  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyToken);
    return value != null && value.isNotEmpty;
  }

  /// Reads the stored token (or placeholder). Returns null if not logged in.
  static Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  /// Clears auth data (call on logout).
  static Future<void> clear() async {
    await _storage.delete(key: _keyToken);
  }
}
