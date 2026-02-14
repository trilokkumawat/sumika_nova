class ForgetState {
  final bool isLoading;
  final String? error;
  final String? message;
  final String? otp;
  final String? email;

  ForgetState({
    this.isLoading = false,
    this.error,
    this.message,
    this.otp,
    this.email,
  });

  ForgetState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    String? otp,
    String? email,
  }) {
    return ForgetState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message ?? this.message,
      otp: otp ?? this.otp,
      email: email ?? this.email,
    );
  }
}
