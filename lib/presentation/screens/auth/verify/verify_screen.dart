import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/presentation/screens/auth/provider.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  final String? extra;
  final Map<String, dynamic>? extraData;
  const VerifyScreen({super.key, this.extra, this.extraData});

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _errorText;

  /// Extract OTP from route extra (email + otp only).
  String? get _serverOtp {
    final data = widget.extraData;
    if (data == null) return null;
    if (data['otp'] != null) return data['otp'].toString();
    return null;
  }

  /// Extract email from route extra (email + otp only).
  String? get _email {
    final data = widget.extraData;
    if (data == null) return null;
    if (data['email'] != null) return data['email'].toString();
    return null;
  }

  /// True when opened from forget-password flow.
  bool get _isForgetPwdFlow =>
      widget.extra == 'forget_pwd' || widget.extraData?['flow'] == 'forget_pwd';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyState = ref.watch(verifyProvider);
    final verifyController = ref.read(verifyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: math.max(220, MediaQuery.sizeOf(context).height / 3.9),
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
                    spacing: 25,
                    children: [
                      if (_serverOtp != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColor.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            'Your OTP: $_serverOtp',
                            textAlign: TextAlign.center,
                            style: TypographyFont.uih4bold.copyWith(
                              color: AppColor.primary,
                            ),
                          ),
                        ),
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
                                  final pin =
                                      value ?? _pinController.text.trim();
                                  if (pin.isEmpty) {
                                    return 'Enter verification code';
                                  }
                                  if (pin.length != 6) {
                                    return 'Enter complete 4-digit code';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Pinput(
                                        controller: _pinController,
                                        length: 6,
                                        onChanged: (pin) =>
                                            state.didChange(pin),
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
                                          if (formKey.currentState!
                                              .validate()) {
                                          } else {
                                            state.didChange(pin);
                                          }
                                        },
                                      ),
                                      if (state.hasError) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          state.errorText!,
                                          style: TypographyFont.uih7reg
                                              .copyWith(color: Colors.red),
                                        ),
                                      ],
                                    ],
                                  );
                                },
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Text(
                              //     'Resend Code',
                              //     style: TypographyFont.uih5bold.copyWith(
                              //       color: const Color(0xFF455AF7),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      if (verifyState.error != null || _errorText != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            verifyState.error ?? _errorText ?? '',
                            style: TypographyFont.uih5reg.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      AppButton(
                        text: verifyState.isLoading
                            ? 'Verifying...'
                            : 'Continue',
                        onPressed: verifyState.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;

                                final enteredPin = _pinController.text.trim();

                                if (_isForgetPwdFlow) {
                                  context.push(
                                    RouteName.createnewpwd,
                                    extra: <String, dynamic>{
                                      'email': _email ?? '',
                                      'otp': enteredPin,
                                    },
                                  );
                                } else {
                                  if (_serverOtp != null &&
                                      enteredPin != _serverOtp) {
                                    setState(() {
                                      _errorText =
                                          'OTP does not match. Please try again.';
                                    });
                                    return;
                                  }

                                  setState(() => _errorText = null);

                                  final email = _email ?? '';
                                  final success = await verifyController
                                      .verifyOtp(email, enteredPin);
                                  if (!mounted) return;
                                  if (success) {
                                    SnakBarUtils.showSnakBar(
                                      context,
                                      'OTP verified successfully',
                                    );
                                    context.push(RouteName.app);
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
      ),
    );
  }
}
