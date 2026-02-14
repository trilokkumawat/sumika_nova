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
import 'package:sumikanova/presentation/screens/auth/provider.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgetState = ref.watch(forgetProvider);
    final forgetController = ref.read(forgetProvider.notifier);

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
                        const CustomBack(isAllowBack: true),
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
                      if (forgetState.error != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            forgetState.error!,
                            style: TypographyFont.uih5reg.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
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
                        text: forgetState.isLoading
                            ? 'Sending...'
                            : 'Send Link',
                        onPressed: forgetState.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;
                                final email = emailController.text.trim();
                                await forgetController.submitEmail(email);
                                if (!mounted) return;
                                final currentState = ref.read(forgetProvider);
                                if (currentState.otp == null) return;
                                context.push(
                                  RouteName.createnewpwd,
                                  extra: <String, dynamic>{
                                    'email': currentState.email ?? email,
                                    'otp': currentState.otp!,
                                  },
                                );
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
