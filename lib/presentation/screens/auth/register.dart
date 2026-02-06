import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/customrichtext.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      spacing: 20,
                      children: [
                        CustomTxtFormField(
                          controller: nameCtl,
                          prefixIcon: Icons.person_outlined,
                          showPrefixIcon: true,
                          hintText: 'Username',
                          labelText: 'Username',
                          validator: (value) {
                            return validationEmpty(value, 'Enter username');
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
                            return validateConfirmPassword(value, pwdCtl.text);
                          },
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
    );
  }
}
