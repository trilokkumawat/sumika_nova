/// Immutable state for the Profile feature.
class ProfileState {
  const ProfileState({
    this.userName,
    this.loading = false,
    this.error,
  });

  final String? userName;
  final bool loading;
  final String? error;

  ProfileState copyWith({
    String? userName,
    bool? loading,
    String? error,
  }) {
    return ProfileState(
      userName: userName ?? this.userName,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
