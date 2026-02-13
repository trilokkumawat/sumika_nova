import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState());

  Future<Map<String, dynamic>?> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.loginCall.call(
        email: email,
        password: password,
      );
      if (response.succeeded) {
        final data = response.jsonBody['data'];
        await SecureAuthStorage.saveLogin(token: data['token']);
        await SecureAuthStorage.saveUserData(data['user']);
        state = state.copyWith(
          isLoading: false,
          message: response.jsonBody['message'],
        );
        return data;
      } else {
        final errorMsg = _extractErrorMessage(response);
        state = state.copyWith(isLoading: false, error: errorMsg);
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
      return null;
    }
  }

  String _extractErrorMessage(ApiCallResponse response) {
    final body = response.jsonBody;
    if (body is Map) {
      if (body.containsKey('errors') && body['errors'] is Map) {
        final errors = body['errors'] as Map;
        final messages = <String>[];
        for (final field in errors.values) {
          if (field is List) {
            messages.addAll(field.map((e) => e.toString()));
          }
        }
        if (messages.isNotEmpty) return messages.join('\n');
      }
      if (body.containsKey('message') && body['message'] != null) {
        return body['message'].toString();
      }
    }
    return 'Request failed (${response.statusCode}). Please try again.';
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
