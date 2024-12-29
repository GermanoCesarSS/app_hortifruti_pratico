// coverage:ignore-file
import 'package:flutter/material.dart';

var colorScheme = ColorScheme.fromSeed(seedColor: Colors.greenAccent);

var radioTheme = RadioThemeData(
    fillColor: WidgetStateColor.resolveWith((states) => colorScheme.primary));

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  radioTheme: radioTheme,
  useMaterial3: true,
);
