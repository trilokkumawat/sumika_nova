import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/custom_modal.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';

class CreateNewPwdScreen extends StatefulWidget {
  const CreateNewPwdScreen({super.key});

  @override
  State<CreateNewPwdScreen> createState() => _CreateNewPwdScreenState();
}

class _CreateNewPwdScreenState extends State<CreateNewPwdScreen> {
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
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 238,
            color: AppColor.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
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
                          ],
                        ),
                      ],
                    ),
                    AppButton(
                      text: 'Reset Password',
                      onPressed: () {
                        // Run empty, password and confirm-password validation on tap
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withValues(alpha: 0.4),

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
    );
  }
}
