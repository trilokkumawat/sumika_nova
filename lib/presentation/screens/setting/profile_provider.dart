import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/setting/profile_controller.dart';
import 'package:sumikanova/presentation/screens/setting/profile_state.dart';

/// Profile feature provider. Watch for state; read notifier for actions.
final profileProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileState>(
  (ref) => ProfileController(),
);
