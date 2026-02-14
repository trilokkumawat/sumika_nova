class VerifyState {
  final bool isLoading;
  final String? error;

  VerifyState({
    this.isLoading = false,
    this.error,
  });

  VerifyState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return VerifyState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
