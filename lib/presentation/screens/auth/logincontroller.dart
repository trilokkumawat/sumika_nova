import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/presentation/screens/auth/loginstate.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(seconds: 2));

    if (email == "admin@gmail.com" && password == "123456") {
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } else {
      state = state.copyWith(isLoading: false, error: "Invalid credentials");
    }
  }

  /// Returns the response jsonBody on success so the caller can navigate
  /// with the data (contains OTP, email, etc.), or null on failure.
  Future<Map<String, dynamic>?> signup(
    String name,
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.registerCall.call(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: password,
      );
      if (response.succeeded) {
        state = state.copyWith(isLoading: false);
        response.jsonBody.addAll({'email': email});
        return response.jsonBody is Map<String, dynamic>
            ? response.jsonBody as Map<String, dynamic>
            : <String, dynamic>{'data': response.jsonBody};
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

  /// Calls verify-register-otp API. Returns true on success.
  Future<bool> verifyOtp(String email, String otp, context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.verifyOtpCall.call(
        email: email,
        otp: otp,
      );
      if (response.statusCode == 200) {
        print('response: ${response.jsonBody}');

        final data = response.jsonBody['data'];
        await SecureAuthStorage.saveLogin(token: data['token']);
        await SecureAuthStorage.saveUserData(data['user']);

        state = state.copyWith(isLoading: false, isLoggedIn: true);
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'OTP verification failed. Please try again.',
      );
      return false;
    }
  }

  /// Extracts a user-friendly error message from a failed API response.
  String _extractErrorMessage(ApiCallResponse response) {
    final body = response.jsonBody;
    if (body is Map) {
      // Handle validation errors: { "errors": { "email": ["..."], ... } }
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
      // Handle single message: { "message": "..." }
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
