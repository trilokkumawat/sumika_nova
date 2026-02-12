class AuthState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;

  AuthState({this.isLoading = false, this.error, this.isLoggedIn = false});

  AuthState copyWith({bool? isLoading, String? error, bool? isLoggedIn}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
