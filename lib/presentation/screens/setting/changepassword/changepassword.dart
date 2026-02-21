import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snackbar.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/presentation/screens/setting/changepassword/change_password_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onChangePassword() async {
    if (!formKey.currentState!.validate()) return;

    final controller = ref.read(changePasswordProvider.notifier);
    await controller.changePassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );
    if (!mounted) return;

    final state = ref.read(changePasswordProvider);
    if (state.success) {
      ref.read(changePasswordProvider.notifier).clearSuccess();
      context.pop();
      SnackBarUtils.showSnackBar(
        context,
        'Password changed successfully',
        behavior: SnackBarBehavior.floating,
      );
    } else if (state.error != null && state.error!.isNotEmpty) {
      SnackBarUtils.showSnackBar(
        context,
        state.error!,
        behavior: SnackBarBehavior.floating,
      );
      ref.read(changePasswordProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordProvider);

    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          const CustomHeader(title: 'Change Password', isAllowBack: true),
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTxtFormField(
                      controller: currentPasswordController,
                      hintText: 'Current Password',
                      labelText: 'Current Password',
                      obscureText: true,
                      showSuffixIcon: true,
                      validator: (value) => validatePassword(value),
                    ),
                    CustomTxtFormField(
                      controller: newPasswordController,
                      hintText: 'New Password',
                      labelText: 'New Password',
                      obscureText: true,
                      showSuffixIcon: true,
                      validator: (value) {
                        final err = validatePassword(value);
                        if (err != null) return err;
                        if (value != null &&
                            value == currentPasswordController.text) {
                          return 'New password must be different from current password';
                        }
                        return null;
                      },
                    ),
                    CustomTxtFormField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      obscureText: true,
                      showSuffixIcon: true,
                      validator: (value) => validateConfirmPassword(
                        value,
                        newPasswordController.text,
                      ),
                    ),
                    AppButton(
                      text: 'Change Password',
                      onPressed: state.isLoading ? null : _onChangePassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
