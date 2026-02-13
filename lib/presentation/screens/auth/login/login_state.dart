class LoginState {
  final bool isLoading;
  final String? error;
  final String? message;

  LoginState({
    this.isLoading = false,
    this.error,
    this.message,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message ?? this.message,
    );
  }
}
