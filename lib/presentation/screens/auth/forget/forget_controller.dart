import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/presentation/screens/auth/forget/forget_state.dart';

class ForgetController extends StateNotifier<ForgetState> {
  ForgetController() : super(ForgetState());

  /// Calls forgot-password API. Returns true on success.
  Future<void> submitEmail(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.forgotPasswordCall.call(
        email: email.trim(),
      );
      if (response.succeeded) {
        final data = response.jsonBody['data'];
        state = state.copyWith(
          isLoading: false,
          message: response.jsonBody['message']?.toString(),
          otp: data['otp']?.toString(),
          email: email,
        );
        return;
      }
      final errorMsg = _extractErrorMessage(response);
      state = state.copyWith(isLoading: false, error: errorMsg);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
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

  void reset() {
    state = ForgetState();
  }
}
