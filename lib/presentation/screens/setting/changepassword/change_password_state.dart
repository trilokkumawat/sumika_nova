/// State for the Change Password screen.
class ChangePasswordState {
  const ChangePasswordState({
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  final bool isLoading;
  final String? error;
  final bool success;

  ChangePasswordState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }
}
