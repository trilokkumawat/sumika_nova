import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/presentation/screens/setting/changepassword/change_password_state.dart';

class ChangePasswordController extends StateNotifier<ChangePasswordState> {
  ChangePasswordController() : super(const ChangePasswordState());

  /// Calls change-password API. Sets [ChangePasswordState.success] on success.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    state = state.copyWith(isLoading: true, error: null, success: false);
    try {
      final response = await SumikiNovaApi.changePasswordCall.call(
        currentPassword: currentPassword,
        password: newPassword,
        passwordConfirmation: passwordConfirmation,
      );
      if (response.succeeded) {
        state = state.copyWith(isLoading: false, success: true, error: null);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        error: _getApiErrorMessage(response),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
    }
  }

  String _getApiErrorMessage(ApiCallResponse response) {
    if (response.jsonBody is Map) {
      final body = response.jsonBody as Map<dynamic, dynamic>;
      final message = body['message'];
      if (message is String && message.isNotEmpty) return message;
      final errors = body['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) {
          return first.first as String? ?? '';
        }
        if (first is String) return first;
      }
    }
    return response.exceptionMessage.isNotEmpty
        ? response.exceptionMessage
        : 'Failed to change password';
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccess() {
    state = state.copyWith(success: false);
  }
}
