import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/customrichtext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Tap again to exit'),
                  behavior: SnackBarBehavior.fixed,
                ),
              );
            }
          } else {
            SystemNavigator.pop();
          }
        },
        child: Column(
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
                                  color: Color(0xFF455AF7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        text: 'Sign In',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.push(RouteName.verify);
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
                          color: AppColor.blue11,
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
    );
  }
}
