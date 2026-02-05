import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

/// Typography using **Afacad only** (Google Fonts). No Inter.
/// UI/H1–H7 scale with Regular, Medium, Semi-Medium, Bold. Use for Figma UI.
class TypographyFont {
  TypographyFont._();

  // ——— UI/H1–H7 font sizes (mobile, Afacad only) ———
  static const double h1Size = 28;
  static const double h2Size = 24;
  static const double h3Size = 20;
  static const double h4Size = 18;
  static const double h5Size = 16;
  static const double h6Size = 14;
  static const double h7Size = 12;

  /// Base text style — Afacad only. Override [fontSize], [fontWeight], [color] as needed.
  static TextStyle afacad({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    LetterSpacing? letterSpacing,
  }) {
    return GoogleFonts.afacad(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColor.primary,
      height: height,
      letterSpacing: letterSpacing?.value,
    );
  }

  /// UI/H1
  static TextStyle get uih1reg =>
      afacad(fontSize: h1Size, fontWeight: FontWeight.w400);
  static TextStyle get uih1med =>
      afacad(fontSize: h1Size, fontWeight: FontWeight.w500);
  static TextStyle get uih1semimed =>
      afacad(fontSize: h1Size, fontWeight: FontWeight.w600);
  static TextStyle get uih1bold =>
      afacad(fontSize: h1Size, fontWeight: FontWeight.bold);

  /// UI/H2
  static TextStyle get uih2reg =>
      afacad(fontSize: h2Size, fontWeight: FontWeight.w400);
  static TextStyle get uih2med =>
      afacad(fontSize: h2Size, fontWeight: FontWeight.w500);
  static TextStyle get uih2semimed =>
      afacad(fontSize: h2Size, fontWeight: FontWeight.w600);
  static TextStyle get uih2bold =>
      afacad(fontSize: h2Size, fontWeight: FontWeight.bold);

  /// UI/H3
  static TextStyle get uih3reg =>
      afacad(fontSize: h3Size, fontWeight: FontWeight.w400);
  static TextStyle get uih3med =>
      afacad(fontSize: h3Size, fontWeight: FontWeight.w500);
  static TextStyle get uih3semimed =>
      afacad(fontSize: h3Size, fontWeight: FontWeight.w600);
  static TextStyle get uih3bold =>
      afacad(fontSize: h3Size, fontWeight: FontWeight.bold);

  /// UI/H4
  static TextStyle get uih4reg =>
      afacad(fontSize: h4Size, fontWeight: FontWeight.w400);
  static TextStyle get uih4med =>
      afacad(fontSize: h4Size, fontWeight: FontWeight.w500);
  static TextStyle get uih4semimed =>
      afacad(fontSize: h4Size, fontWeight: FontWeight.w600);
  static TextStyle get uih4bold =>
      afacad(fontSize: h4Size, fontWeight: FontWeight.bold);

  /// UI/H5
  static TextStyle get uih5reg =>
      afacad(fontSize: h5Size, fontWeight: FontWeight.w400);
  static TextStyle get uih5med =>
      afacad(fontSize: h5Size, fontWeight: FontWeight.w500);
  static TextStyle get uih5semimed =>
      afacad(fontSize: h5Size, fontWeight: FontWeight.w600);
  static TextStyle get uih5bold =>
      afacad(fontSize: h5Size, fontWeight: FontWeight.bold);

  /// UI/H6
  static TextStyle get uih6reg =>
      afacad(fontSize: h6Size, fontWeight: FontWeight.w400);
  static TextStyle get uih6med =>
      afacad(fontSize: h6Size, fontWeight: FontWeight.w500);
  static TextStyle get uih6semimed =>
      afacad(fontSize: h6Size, fontWeight: FontWeight.w600);
  static TextStyle get uih6bold =>
      afacad(fontSize: h6Size, fontWeight: FontWeight.bold);

  /// UI/H7
  static TextStyle get uih7reg =>
      afacad(fontSize: h7Size, fontWeight: FontWeight.w400);
  static TextStyle get uih7med =>
      afacad(fontSize: h7Size, fontWeight: FontWeight.w500);
  static TextStyle get uih7semimed =>
      afacad(fontSize: h7Size, fontWeight: FontWeight.w600);
  static TextStyle get uih7bold =>
      afacad(fontSize: h7Size, fontWeight: FontWeight.bold);

  /// Call by level and weight. [level] 1–7, [weight] Regular/Medium/SemiMedium/Bold.
  static TextStyle ui(int level, UiWeight weight, {Color? color}) {
    final size = _sizeForLevel(level);
    final fontWeight = weight.fontWeight;
    return afacad(fontSize: size, fontWeight: fontWeight, color: color);
  }

  static double _sizeForLevel(int level) {
    switch (level) {
      case 1:
        return h1Size;
      case 2:
        return h2Size;
      case 3:
        return h3Size;
      case 4:
        return h4Size;
      case 5:
        return h5Size;
      case 6:
        return h6Size;
      case 7:
        return h7Size;
      default:
        return h5Size;
    }
  }

  /// Full [TextTheme] — Afacad only, sizes mapped from UI/H1–H7.
  static TextTheme get textTheme {
    final base = GoogleFonts.afacadTextTheme();
    return TextTheme(
      displayLarge: base.displayLarge!.copyWith(
        fontSize: h1Size,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontSize: h2Size,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontSize: h3Size,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontSize: h3Size,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontSize: h4Size,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontSize: h4Size,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontSize: h4Size,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontSize: h5Size,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontSize: h6Size,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontSize: h5Size,
        fontWeight: FontWeight.normal,
        color: AppColor.primary,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: h5Size,
        fontWeight: FontWeight.normal,
        color: AppColor.primary,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontSize: h6Size,
        fontWeight: FontWeight.normal,
        color: AppColor.primary,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontSize: h6Size,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontSize: h7Size,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontSize: h7Size,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
    );
  }
}

/// UI weight: Regular, Medium, Semi-Medium, Bold. Afacad only.
enum UiWeight {
  regular(FontWeight.w400),
  medium(FontWeight.w500),
  semiMedium(FontWeight.w600),
  bold(FontWeight.bold);

  const UiWeight(this.fontWeight);
  final FontWeight fontWeight;
}

/// Optional letter spacing (e.g. from Figma). Afacad only.
enum LetterSpacing {
  tight(-0.5),
  normal(0),
  wide(0.5);

  const LetterSpacing(this.value);
  final double value;
}
