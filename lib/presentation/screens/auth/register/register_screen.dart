import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/customrichtext.dart';
import 'package:sumikanova/presentation/screens/auth/provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController pwdCtl = TextEditingController();
  final TextEditingController cfmpwdCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameCtl.dispose();
    emailCtl.dispose();
    pwdCtl.dispose();
    cfmpwdCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    final registerController = ref.read(registerProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: math.max(220, MediaQuery.sizeOf(context).height / 3.9),
              color: AppColor.black,
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
                      color: Color(0xFF353535),
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
                              "Let's get started",
                              style: TypographyFont.uih1bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'we are happy to see you here. Sign Up to your account.',
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
                        spacing: 20,
                        children: [
                          CustomTxtFormField(
                            controller: nameCtl,
                            prefixIcon: Icons.person_outlined,
                            showPrefixIcon: true,
                            hintText: 'Your Name',
                            labelText: 'Your Name',
                            validator: (value) {
                              return validationEmpty(value, 'Enter your name');
                            },
                          ),
                          CustomTxtFormField(
                            controller: emailCtl,
                            prefixIcon: Icons.email_outlined,
                            showPrefixIcon: true,
                            hintText: 'Email',
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return validateEmail(value);
                            },
                          ),
                          CustomTxtFormField(
                            controller: pwdCtl,
                            prefixIcon: Icons.lock_outline_rounded,
                            showPrefixIcon: true,
                            hintText: 'Password',
                            labelText: 'Password',
                            obscureText: true,
                            showSuffixIcon: true,
                            validator: (value) {
                              return validatePassword(value);
                            },
                          ),
                          CustomTxtFormField(
                            controller: cfmpwdCtl,
                            prefixIcon: Icons.lock_outline_rounded,
                            showPrefixIcon: true,
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            obscureText: true,
                            showSuffixIcon: true,
                            validator: (value) {
                              return validateConfirmPassword(
                                value,
                                pwdCtl.text,
                              );
                            },
                          ),
                        ],
                      ),
                      if (registerState.error != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            registerState.error!,
                            style: TypographyFont.uih5reg.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      AppButton(
                        text: 'Sign Up',
                        onPressed: registerState.isLoading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  final responseData = await registerController
                                      .signup(
                                        nameCtl.text,
                                        emailCtl.text,
                                        pwdCtl.text,
                                      );
                                  if (responseData != null && mounted) {
                                    final otp = responseData['otp']?.toString();
                                    if (otp != null) {
                                      context.push(
                                        RouteName.verify,
                                        extra: <String, dynamic>{
                                          'email': emailCtl.text,
                                          'otp': otp,
                                        },
                                      );
                                    }
                                  }
                                }
                              },
                      ),
                      CustomRichText(
                        normalText: "Have an account? ",
                        actionText: "Sign In",
                        normalStyle: TypographyFont.uih5reg.copyWith(
                          color: AppColor.gray11,
                        ),
                        actionStyle: TypographyFont.uih5bold.copyWith(
                          color: AppColor.blue11,
                        ),
                        onTap: () {
                          context.pop();
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
