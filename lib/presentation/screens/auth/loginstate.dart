class AuthState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;
  final String? message;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
    this.message,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    String? message,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      message: message ?? this.message,
    );
  }
}
