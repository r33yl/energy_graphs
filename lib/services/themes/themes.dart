import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const scheme = FlexScheme.green;

  static final lightTheme = FlexThemeData.light(
    scheme: scheme,
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    useMaterial3: true,
    blendLevel: 4,
    subThemesData: const FlexSubThemesData(
      // text field
      defaultRadius: 8,
      inputDecoratorIsFilled: false,
      inputDecoratorUnfocusedBorderIsColored: false,
      // button
      textButtonRadius: 32,
      filledButtonRadius: 32,
      elevatedButtonRadius: 32,
      outlinedButtonRadius: 32,
      // dialog
      dialogRadius: 32,
    ),
  ).copyWith(
    timePickerTheme: const TimePickerThemeData().copyWith(
      helpTextStyle: const TextStyle(fontSize: 22),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
    ),
  );

  static final darkTheme = FlexThemeData.dark(
    scheme: scheme,
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    useMaterial3: true,
    blendLevel: 4,
    subThemesData: const FlexSubThemesData(
      // text field
      defaultRadius: 8,
      inputDecoratorIsFilled: false,
      inputDecoratorUnfocusedBorderIsColored: false,
      // button
      textButtonRadius: 32,
      filledButtonRadius: 32,
      elevatedButtonRadius: 32,
      outlinedButtonRadius: 32,
      // dialog
      dialogRadius: 32,
    ),
  ).copyWith(
    timePickerTheme: const TimePickerThemeData().copyWith(
      helpTextStyle: const TextStyle(fontSize: 22),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
    ),
  );
}
