import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(RegisterState());

  /// Returns the response data on success so the caller can navigate
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
        final data = response.jsonBody['data'];
        state = state.copyWith(isLoading: false);
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
