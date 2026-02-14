import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/presentation/screens/auth/newpassword/createnewpwd_state.dart';

class CreateNewPwdController extends StateNotifier<CreateNewPwdState> {
  CreateNewPwdController() : super(CreateNewPwdState());

  /// Calls reset-password API. Returns true on success.
  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await SumikiNovaApi.resetPasswordCall.call(
        email: email.trim(),
        otp: otp.trim(),
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (response.succeeded) {
        state = state.copyWith(isLoading: false);
        return true;
      }
      final errorMsg = _extractErrorMessage(response);
      state = state.copyWith(isLoading: false, error: errorMsg);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
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
