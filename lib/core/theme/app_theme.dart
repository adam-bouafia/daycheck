import 'package:flutter/material.dart';

/// Catppuccin (catppuccin.com, MIT): Latte for light mode, Mocha for dark.
/// Same palette as my other Flutter project, MetJou.
abstract final class Latte {
  static const base = Color(0xffeff1f5);
  static const mantle = Color(0xffe6e9ef);
  static const crust = Color(0xffdce0e8);
  static const surface0 = Color(0xffccd0da);
  static const surface1 = Color(0xffbcc0cc);
  static const overlay0 = Color(0xff9ca0b0);
  static const subtext0 = Color(0xff6c6f85);
  static const text = Color(0xff4c4f69);
  static const mauve = Color(0xff8839ef);
  static const pink = Color(0xffea76cb);
  static const red = Color(0xffd20f39);
  static const peach = Color(0xfffe640b);
  static const teal = Color(0xff179299);
  static const blue = Color(0xff1e66f5);
}

abstract final class Mocha {
  static const crust = Color(0xff11111b);
  static const mantle = Color(0xff181825);
  static const base = Color(0xff1e1e2e);
  static const surface0 = Color(0xff313244);
  static const surface1 = Color(0xff45475a);
  static const overlay0 = Color(0xff6c7086);
  static const subtext0 = Color(0xffa6adc8);
  static const text = Color(0xffcdd6f4);
  static const mauve = Color(0xffcba6f7);
  static const pink = Color(0xfff5c2e7);
  static const red = Color(0xfff38ba8);
  static const teal = Color(0xff94e2d5);
}

const _lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Latte.mauve,
  onPrimary: Colors.white,
  primaryContainer: Color(0xffeadcfd),
  onPrimaryContainer: Color(0xff3b1470),
  secondary: Latte.pink,
  onSecondary: Colors.white,
  tertiary: Latte.teal,
  onTertiary: Colors.white,
  error: Latte.red,
  onError: Colors.white,
  surface: Latte.base,
  onSurface: Latte.text,
  onSurfaceVariant: Latte.subtext0,
  surfaceContainerLowest: Colors.white,
  surfaceContainerLow: Color(0xfff5f6f9),
  surfaceContainer: Latte.mantle,
  surfaceContainerHigh: Latte.crust,
  surfaceContainerHighest: Latte.surface0,
  outline: Latte.overlay0,
  outlineVariant: Latte.surface1,
);

const _darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Mocha.mauve,
  onPrimary: Mocha.crust,
  primaryContainer: Color(0xff47386a),
  onPrimaryContainer: Color(0xffeadcfd),
  secondary: Mocha.pink,
  onSecondary: Mocha.crust,
  tertiary: Mocha.teal,
  onTertiary: Mocha.crust,
  error: Mocha.red,
  onError: Mocha.crust,
  surface: Mocha.base,
  onSurface: Mocha.text,
  onSurfaceVariant: Mocha.subtext0,
  surfaceContainerLowest: Mocha.crust,
  surfaceContainerLow: Mocha.mantle,
  surfaceContainer: Color(0xff262637),
  surfaceContainerHigh: Mocha.surface0,
  surfaceContainerHighest: Mocha.surface1,
  outline: Mocha.overlay0,
  outlineVariant: Mocha.surface1,
);

ThemeData _theme(Brightness brightness) {
  final scheme = brightness == Brightness.light ? _lightScheme : _darkScheme;
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    cardTheme: CardThemeData(
      color: scheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: scheme.onSurface,
    ),
    listTileTheme: ListTileThemeData(iconColor: scheme.onSurfaceVariant),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: 0.6),
    ),
  );
}

final appTheme = _theme(Brightness.light);
final appDarkTheme = _theme(Brightness.dark);
