import 'package:flutter/material.dart';

abstract final class AppColors {
  static const lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006A60),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF9EF2E4),
    onPrimaryContainer: Color(0xFF00201C),
    secondary: Color(0xFF4A635F),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCCE8E2),
    onSecondaryContainer: Color(0xFF051F1C),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFF4FBF8),
    onSurface: Color(0xFF161D1C),
    onSurfaceVariant: Color(0xFF3F4947),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFEEF5F2),
    surfaceContainer: Color(0xFFE8EFEC),
    surfaceContainerHigh: Color(0xFFE2E9E6),
    surfaceContainerHighest: Color(0xFFDCE4E1),
    outline: Color(0xFF6F7977),
    outlineVariant: Color(0xFFBEC9C6),
    inverseSurface: Color(0xFF2B3230),
    onInverseSurface: Color(0xFFECF2EF),
    inversePrimary: Color(0xFF82D5C8),
  );

  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF82D5C8),
    onPrimary: Color(0xFF003731),
    primaryContainer: Color(0xFF005048),
    onPrimaryContainer: Color(0xFF9EF2E4),
    secondary: Color(0xFFB1CCC6),
    onSecondary: Color(0xFF1C3531),
    secondaryContainer: Color(0xFF334B47),
    onSecondaryContainer: Color(0xFFCCE8E2),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF0E1513),
    onSurface: Color(0xFFDDE4E1),
    onSurfaceVariant: Color(0xFFBEC9C6),
    surfaceContainerLowest: Color(0xFF090F0E),
    surfaceContainerLow: Color(0xFF161D1C),
    surfaceContainer: Color(0xFF1A2120),
    surfaceContainerHigh: Color(0xFF252B2A),
    surfaceContainerHighest: Color(0xFF2F3635),
    outline: Color(0xFF899390),
    outlineVariant: Color(0xFF3F4947),
    inverseSurface: Color(0xFFDDE4E1),
    onInverseSurface: Color(0xFF2B3230),
    inversePrimary: Color(0xFF006A60),
  );
}

extension AppColorSchemeX on ColorScheme {
  bool get _isLight => brightness == Brightness.light;

  Color get positive =>
      _isLight ? const Color(0xFF146C2E) : const Color(0xFF7FDB98);

  Color get negative =>
      _isLight ? const Color(0xFFBA1A1A) : const Color(0xFFFFB4AB);

  Color get warning =>
      _isLight ? const Color(0xFF8B5000) : const Color(0xFFFFB870);

  Color balanceColor(int amount) {
    if (amount > 0) return positive;
    if (amount < 0) return negative;
    return onSurfaceVariant;
  }
}
