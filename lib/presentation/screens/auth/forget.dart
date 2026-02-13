import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                              'Reset Password',
                              style: TypographyFont.uih1bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Enter your email, we will send a verification code to your email',
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
                            ],
                          ),
                        ],
                      ),
                      AppButton(
                        text: 'Send Link',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.push(RouteName.verify, extra: 'forget_pwd');
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
