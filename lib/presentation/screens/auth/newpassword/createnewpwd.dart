import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/custom_modal.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/presentation/screens/auth/provider.dart';

class CreateNewPwdScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? extra;
  const CreateNewPwdScreen({super.key, this.extra});

  @override
  ConsumerState<CreateNewPwdScreen> createState() => _CreateNewPwdScreenState();
}

class _CreateNewPwdScreenState extends ConsumerState<CreateNewPwdScreen> {
  final TextEditingController pwdCtl = TextEditingController();
  final TextEditingController cfmpwdCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cfmpwdCtl.dispose();
    pwdCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createNewPwdState = ref.watch(createNewPwdProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 3.9,
              color: AppColor.primary,
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/icons/bgappbar.png',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 50,
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBack(isAllowBack: true),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Create New Password',
                              style: TypographyFont.uih1bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Your password must be different from previous used password',
                              style: TypographyFont.uih3reg.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 50,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 32,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          Column(
                            spacing: 20,
                            children: [
                              CustomTxtFormField(
                                controller: pwdCtl,
                                prefixIcon: Icons.lock_outline_rounded,
                                showPrefixIcon: true,
                                hintText: 'Password',
                                labelText: 'Password',
                                obscureText: true,
                                showSuffixIcon: true,
                                validator: validatePassword,
                              ),
                              CustomTxtFormField(
                                controller: cfmpwdCtl,
                                prefixIcon: Icons.lock_outline_rounded,
                                showPrefixIcon: true,
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                obscureText: true,
                                showSuffixIcon: true,
                                validator: (value) =>
                                    validateConfirmPassword(value, pwdCtl.text),
                              ),
                              if (createNewPwdState.error != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    createNewPwdState.error!,
                                    style: TypographyFont.uih5reg.copyWith(
                                      color: AppColor.red,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      AppButton(
                        text: 'Reset Password',
                        onPressed: createNewPwdState.isLoading
                            ? null
                            : () async {
                                ref
                                    .read(createNewPwdProvider.notifier)
                                    .clearError();
                                final isValid = formKey.currentState!
                                    .validate();
                                if (!isValid) return;
                                final email =
                                    widget.extra?['email']?.toString() ?? '';
                                final otp =
                                    widget.extra?['otp']?.toString() ?? '';
                                if (email.isEmpty || otp.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Missing email or OTP. Please start from forgot password.',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                final success = await ref
                                    .read(createNewPwdProvider.notifier)
                                    .resetPassword(
                                      email: email,
                                      otp: otp,
                                      password: pwdCtl.text,
                                      passwordConfirmation: cfmpwdCtl.text,
                                    );
                                if (!context.mounted) return;
                                if (success) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    barrierColor: Colors.black.withValues(
                                      alpha: 0.4,
                                    ),
                                    builder: (context) => CustomModal(
                                      onPressed: () {
                                        context.go(RouteName.login);
                                      },
                                    ),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
