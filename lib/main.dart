import 'package:daycheck/core/theme/app_theme.dart';
import 'package:daycheck/features/roster/presentation/roster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DayCheck',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: appDarkTheme,
      home: const RosterScreen(),
    );
  }
}
