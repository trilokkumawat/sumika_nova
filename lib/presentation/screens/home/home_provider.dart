import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/home/home_controller.dart';
import 'package:sumikanova/presentation/screens/home/home_state.dart';

/// Watch this for home screen state; read [homeProvider.notifier] for actions.
final homeProvider = StateNotifierProvider.autoDispose<HomeController, HomeScreenState>(
  (ref) => HomeController(),
);
