import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/presentation/screens/setting/profile_state.dart';

/// Controller for Profile screen. All state changes go through here.
class ProfileController extends StateNotifier<ProfileState> {
  ProfileController() : super(const ProfileState());

  /// Loads user data from [SecureAuthStorage] and updates state.
  Future<void> loadUserData() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final userData = await SecureAuthStorage.getUserData();
      final name = userData?['name']?.toString();
      state = state.copyWith(
        userName: name,
        loading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Could not load profile',
      );
    }
  }

  /// Updates displayed name after a successful edit (e.g. from bottom sheet).
  void setUserName(String name) {
    state = state.copyWith(userName: name);
  }
}
