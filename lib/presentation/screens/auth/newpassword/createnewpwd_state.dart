class CreateNewPwdState {
  final bool isLoading;
  final String? error;

  CreateNewPwdState({
    this.isLoading = false,
    this.error,
  });

  CreateNewPwdState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return CreateNewPwdState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
