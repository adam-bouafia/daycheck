import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1e66f5)),
  useMaterial3: true,
);

final appDarkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff1e66f5),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
