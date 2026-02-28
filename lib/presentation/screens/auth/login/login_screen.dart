import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/app_logger.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snackbar.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/customrichtext.dart';
import 'package:sumikanova/core/widget/errorshow.dart';
import 'package:sumikanova/presentation/screens/auth/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _lastBackPress;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginController = ref.read(loginProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final now = DateTime.now();
          if (_lastBackPress == null ||
              now.difference(_lastBackPress!).inSeconds >= 2) {
            _lastBackPress = now;
            if (mounted) {
              SnackBarUtils.showSnackBar(context, 'Tap again to exit');
            }
          } else {
            SystemNavigator.pop();
          }
        },
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: math.max(220, MediaQuery.sizeOf(context).height / 3.9),
                decoration: BoxDecoration(color: AppColor.black),
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
                          CustomBack(title: 'Login'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                'Welcome to Sumika Nova',
                                style: TypographyFont.uih1bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Provide below information to login into your account.',
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
                                  controller: emailController,
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
                                  controller: passwordController,
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
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  context.push(RouteName.forget);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TypographyFont.uih5bold.copyWith(
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                            ),
                            if (loginState.error != null)
                              CustomErrorShow(errorMessage: loginState.error!),
                          ],
                        ),
                        AppButton(
                          text: 'Sign In',
                          onPressed: loginState.isLoading
                              ? null
                              : () async {
                                  if (!formKey.currentState!.validate()) return;
                                  final email = emailController.text.trim();
                                  final password = passwordController.text
                                      .trim();
                                  final data = await loginController.login(
                                    email,
                                    password,
                                  );

                                  if (!mounted) return;
                                  AppLogger.d('data: ${loginState.error}');

                                  if (loginState.isLoading == false &&
                                      loginState.error == null &&
                                      loginState.error !=
                                          'Invalid credentials') {
                                    SnackBarUtils.showSnackBar(
                                      context,
                                      loginState.message ?? 'Login successful',
                                    );

                                    context.go(RouteName.app);
                                  }
                                },
                        ),
                        CustomRichText(
                          normalText: "Don't have an account? ",
                          actionText: "Sign Up",
                          normalStyle: TypographyFont.uih5reg.copyWith(
                            color: AppColor.gray11,
                          ),
                          actionStyle: TypographyFont.uih5bold.copyWith(
                            color: AppColor.black,
                          ),
                          onTap: () {
                            context.push(RouteName.register);
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
      ),
    );
  }
}
