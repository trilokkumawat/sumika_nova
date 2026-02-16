import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/snakbar.dart';

String? validateEmail(String? value, {String? msg}) {
  if (value == null || value.trim().isEmpty) {
    return msg ?? 'Enter your email address';
  }

  // Email RFC 5322 compliant regex (covers most valid emails)
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  final trimmedValue = value.trim();

  if (!emailRegex.hasMatch(trimmedValue)) {
    return 'Enter valid email address';
  }

  // Check for gmail.com or googlemail.com specifically
  if (!trimmedValue.toLowerCase().contains('@gmail.com')) {
    return 'Email must be a Gmail address';
  }

  return null;
}

/// Validate password input
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }

  if (value.length < 8) {
    return "Password must be at least 8 characters";
  }

  // Block only numbers like 12345678
  if (RegExp(r'^\d+$').hasMatch(value)) {
    return "Password cannot be only numbers";
  }

  // Block common weak numeric passwords
  List<String> weakPasswords = [
    "123456",
    "12345678",
    "123456789",
    "00000000",
    "11111111",
  ];

  if (weakPasswords.contains(value)) {
    return "This password is too common";
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Include at least one uppercase letter";
  }

  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Include at least one lowercase letter";
  }

  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "Include at least one number";
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return "Include at least one special character";
  }

  return null;
}

/// Validate confirm password matches the given [password]
String? validateConfirmPassword(String? value, String? password) {
  final emptyError = validationEmpty(value, 'Enter your confirm password');
  if (emptyError != null) return emptyError;
  if (value != password) return 'Passwords do not match';
  return null;
}

String? validationEmpty(String? value, message) {
  if (value == null || value.isEmpty) {
    return message;
  }

  return null;
}

extension SentenceCase on String {
  String sentenceCase() =>
      isEmpty ? this : this[0].toUpperCase() + substring(1).toLowerCase();
}

extension TitleCase on String {
  String titleCase() {
    return split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  if (hour < 21) return 'Good Evening';
  return 'Good Night';
}

void logout(BuildContext context) async {
  await SecureAuthStorage.clear();
  if (context.mounted) {
    context.go(RouteName.login);
    SnakBarUtils.showSnakBar(
      context,
      'User logged out successfully',
      bgcolor: AppColor.green,
      textColor: Colors.white,
      behavior: SnackBarBehavior.floating,
    );
  }
}
