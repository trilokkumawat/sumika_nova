import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_controller.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_state.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_controller.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_state.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_controller.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_state.dart';

final loginProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) => LoginController());

final registerProvider = StateNotifierProvider<RegisterController, RegisterState>(
  (ref) => RegisterController(),
);

final verifyProvider =
    StateNotifierProvider<VerifyController, VerifyState>((ref) => VerifyController());
