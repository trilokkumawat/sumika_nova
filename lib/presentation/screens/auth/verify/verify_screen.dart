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

  /// Extract OTP from the API response data.
  String? get _serverOtp {
    final data = widget.extraData;
    if (data == null) return null;
    if (data['data'] is Map && data['data']['otp'] != null) {
      return data['data']['otp'].toString();
    }
    if (data['otp'] != null) return data['otp'].toString();
    return null;
  }

  /// Extract email from the API response data.
  String? get _email {
    final data = widget.extraData;
    if (data == null) return null;
    if (data['data'] is Map && data['data']['email'] != null) {
      return data['data']['email'].toString();
    }
    if (data['email'] != null) return data['email'].toString();
    return null;
  }

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
                                final pin = value ?? _pinController.text.trim();
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Pinput(
                                      controller: _pinController,
                                      length: 6,
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
                                  color: const Color(0xFF455AF7),
                                ),
                              ),
                            ),
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
                      text: verifyState.isLoading ? 'Verifying...' : 'Continue',
                      onPressed: verifyState.isLoading
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) return;

                              final enteredPin = _pinController.text.trim();

                              if (widget.extra == 'forget_pwd') {
                                context.push(RouteName.createnewpwd);
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
                                    bgcolor: AppColor.green,
                                    textColor: Colors.white,
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
    );
  }
}
