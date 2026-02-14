import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';

String? validateEmail(String? value, {String? msg}) {
  if (value == null || value.trim().isEmpty) {
    return msg ?? 'Enter your email address';
  }

  // Email RFC 5322 compliant regex (covers most valid emails)
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  if (!emailRegex.hasMatch(value.trim())) {
    return 'Enter valid email address';
  }

  return null;
}

/// Validate password input
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your password';
  }
  if (value.length < 6) {
    return 'Use at least 6 characters';
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
  }
}
