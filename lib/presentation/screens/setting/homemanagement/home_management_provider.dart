import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_controller.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_state.dart';

/// Single provider for the Home Management feature.
/// Watch this for state; read [homeManagementProvider.notifier] for actions.
final homeManagementProvider = StateNotifierProvider.autoDispose<
    HomeManagementController, HomeManagementState>(
  (ref) => HomeManagementController(),
);
