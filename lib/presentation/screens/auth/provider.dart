import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/auth/logincontroller.dart';
import 'package:sumikanova/presentation/screens/auth/loginstate.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);
