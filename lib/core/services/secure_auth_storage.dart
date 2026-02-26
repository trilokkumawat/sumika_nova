import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for auth state in this project only.
/// Use [saveLogin] on sign in and [clear] on logout.
class SecureAuthStorage {
  SecureAuthStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyToken = 'auth_token';
  static const String _keyUserdtl = 'userdtl';
  static const String _keyHomeIdLocal = 'homeidlocal';

  /// Saves login state (call after successful sign in).
  static Future<void> saveLogin({String? token}) async {
    await _storage.write(key: _keyToken, value: token);
  }

  /// Saves user detail map as JSON string.
  static Future<void> saveUserData(Map<String, dynamic> data) async {
    await _storage.write(key: _keyUserdtl, value: jsonEncode(data));
  }

  /// Reads the stored user detail map. Returns null if not saved.
  static Future<Map<String, dynamic>?> getUserData() async {
    final value = await _storage.read(key: _keyUserdtl);
    if (value == null || value.isEmpty) return null;
    return jsonDecode(value) as Map<String, dynamic>;
  }

  /// Returns true if user is logged in (token exists).
  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyToken);
    return value != null && value.isNotEmpty;
  }

  /// Reads the stored token. Returns null if not logged in.
  static Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  /// Saves selected home id (e.g. from home dropdown). Use null to remove.
  static Future<void> saveHomeIdLocal(String? homeId) async {
    if (homeId == null || homeId.isEmpty) {
      await _storage.delete(key: _keyHomeIdLocal);
    } else {
      await _storage.write(key: _keyHomeIdLocal, value: homeId);
    }
  }

  /// Reads the stored selected home id. Returns null if not saved.
  static Future<String?> getHomeIdLocal() async {
    return _storage.read(key: _keyHomeIdLocal);
  }

  /// Clears all auth data (call on logout).
  static Future<void> clear() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyUserdtl);
    await _storage.delete(key: _keyHomeIdLocal);
  }
}
