import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_state.dart';

class VerifyController extends StateNotifier<VerifyState> {
  VerifyController() : super(VerifyState());

  /// Calls verify-register-otp API. Returns true on success.
  Future<bool> verifyOtp(String email, String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.verifyOtpCall.call(
        email: email,
        otp: otp,
      );
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      }
      final errorMsg = _extractErrorMessage(response);
      state = state.copyWith(isLoading: false, error: errorMsg);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'OTP verification failed. Please try again.',
      );
      return false;
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
