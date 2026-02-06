import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';

class VerifyScreen extends StatefulWidget {
  final String? extra;
  const VerifyScreen({super.key, this.extra});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinController.dispose();
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
                          'Verification Code',
                          style: TypographyFont.uih1bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Enter the verification code that we have sent to your email',
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
                  spacing: 25,
                  children: [
                    Column(
                      spacing: 10,
                      children: [
                        Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FormField<String>(
                              initialValue: '',
                              validator: (value) {
                                final pin = value ?? _pinController.text.trim();
                                if (pin.isEmpty) {
                                  return 'Enter verification code';
                                }
                                if (pin.length != 4) {
                                  return 'Enter complete 4-digit code';
                                }
                                return null;
                              },
                              builder: (state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Pinput(
                                      controller: _pinController,
                                      length: 4,
                                      onChanged: (pin) => state.didChange(pin),
                                      defaultPinTheme: PinTheme(
                                        width: 56,
                                        height: 56,
                                        textStyle: TypographyFont.uih4bold
                                            .copyWith(color: AppColor.gray8),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: state.hasError
                                                ? Colors.red
                                                : AppColor.gray3,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      focusedPinTheme: PinTheme(
                                        width: 56,
                                        height: 56,
                                        textStyle: TypographyFont.uih4bold
                                            .copyWith(color: AppColor.gray8),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: state.hasError
                                                ? Colors.red
                                                : AppColor.primary,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      submittedPinTheme: PinTheme(
                                        width: 56,
                                        height: 56,
                                        textStyle: TypographyFont.uih4bold
                                            .copyWith(color: AppColor.gray8),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: state.hasError
                                                ? Colors.red
                                                : AppColor.primary,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      onCompleted: (pin) {
                                        if (formKey.currentState!.validate()) {
                                        } else {
                                          state.didChange(pin);
                                        }
                                      },
                                    ),
                                    if (state.hasError) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        state.errorText!,
                                        style: TypographyFont.uih7reg.copyWith(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Resend Code',
                                style: TypographyFont.uih5bold.copyWith(
                                  color: Color(0xFF455AF7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppButton(
                      text: 'Continue',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (widget.extra == 'forget_pwd') {
                            context.push(RouteName.createnewpwd);
                          } else {
                            context.push(RouteName.home);
                          }
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
