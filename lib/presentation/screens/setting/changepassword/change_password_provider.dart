import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/presentation/screens/setting/changepassword/change_password_controller.dart';
import 'package:sumikanova/presentation/screens/setting/changepassword/change_password_state.dart';

final changePasswordProvider = StateNotifierProvider.autoDispose<
    ChangePasswordController, ChangePasswordState>(
  (ref) => ChangePasswordController(),
);
