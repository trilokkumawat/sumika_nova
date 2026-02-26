import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/data/user/user_model.dart';

/// Returns the stored auth token, or null if not logged in.
Future<String?> getAuthToken() async {
  final token = await SecureAuthStorage.getToken();
  if (token == null || token.isEmpty) return null;
  return token;
}

/// Returns the stored user as [UserModel], or null if not saved.
Future<UserModel?> getUserInfo() async {
  final map = await SecureAuthStorage.getUserData();
  if (map == null) return null;
  return UserModel.fromJson(map);
}
