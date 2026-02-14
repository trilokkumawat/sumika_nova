import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/auth/forget/forget_controller.dart';
import 'package:sumikanova/presentation/screens/auth/forget/forget_state.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_controller.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_state.dart';
import 'package:sumikanova/presentation/screens/auth/newpassword/create_new_pwd_controller.dart';
import 'package:sumikanova/presentation/screens/auth/newpassword/createnewpwd_state.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_controller.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_state.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_controller.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_state.dart';

final createNewPwdProvider =
    StateNotifierProvider.autoDispose<CreateNewPwdController, CreateNewPwdState>(
      (ref) => CreateNewPwdController(),
    );

final forgetProvider =
    StateNotifierProvider.autoDispose<ForgetController, ForgetState>(
      (ref) => ForgetController(),
    );

final loginProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
      (ref) => LoginController(),
    );

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterController, RegisterState>(
      (ref) => RegisterController(),
    );

final verifyProvider =
    StateNotifierProvider.autoDispose<VerifyController, VerifyState>(
      (ref) => VerifyController(),
    );
