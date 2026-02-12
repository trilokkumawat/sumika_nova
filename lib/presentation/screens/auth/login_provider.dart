import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';

/// Parses token from login API response. Tries common response shapes.
String? _tokenFromResponse(ApiCallResponse response) {
  if (response.jsonBody == null || response.jsonBody is! Map) return null;
  final map = response.jsonBody as Map<dynamic, dynamic>;
  final token = map['token'] ?? map['access_token'];
  if (token != null && token is String) return token;
  final data = map['data'];
  if (data is Map) {
    final t = data['token'] ?? data['access_token'];
    if (t != null && t is String) return t;
  }
  return null;
}

/// Builds user-facing error message from API response.
String _messageFromResponse(ApiCallResponse response) {
  if (response.jsonBody is Map) {
    final map = response.jsonBody as Map<dynamic, dynamic>;
    final msg = map['message'] ?? map['error'];
    if (msg is String) return msg;
    if (msg is Map && msg.isNotEmpty) return msg.values.first?.toString() ?? 'Login failed';
  }
  return response.exceptionMessage.isNotEmpty
      ? response.exceptionMessage
      : 'Login failed (${response.statusCode})';
}

/// Riverpod state for login: idle, loading, success, or error.
final loginNotifierProvider =
    AsyncNotifierProvider<LoginNotifier, void>(LoginNotifier.new);

class LoginNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Calls login API with [email] and [password]. On success saves token and
  /// completes; on failure throws [ApiException] or error message.
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await SumikiNovaApi.loginCall.call(
        email: email,
        password: password,
      );
      if (!response.succeeded) {
        throw ApiException(
          _messageFromResponse(response),
          statusCode: response.statusCode,
        );
      }
      final token = _tokenFromResponse(response);
      await SecureAuthStorage.saveLogin(token: token);
    });
  }
}
