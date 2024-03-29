// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeProvider = StateNotifierProvider<ThemeManager, ThemeMode>((ref) {
  return ThemeManager();
});

class ThemeManager extends StateNotifier<ThemeMode> {
  ThemeManager() : super(ThemeMode.dark);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void setLightMode() {
    state = ThemeMode.light;
  }

  void setDarkMode() {
    state = ThemeMode.dark;
  }
}

///

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    // general
    required this.background,
    required this.backgroundCompliment,
    required this.textColor,
    required this.border,
    // navbar
    required this.navbarBackground,
    //
    required this.buttonGrey,
    required this.buttonPrimary,
    // progress bars
    required this.progressBarBackground,
    required this.progressBarForeground,
  });
  final Color? background;
  final Color? backgroundCompliment;
  final Color? textColor;
  final Color? border;

  final Color? navbarBackground;

  final Color? buttonGrey;
  final Color? buttonPrimary;

  final Color? progressBarBackground;
  final Color? progressBarForeground;

  @override
  CustomColors copyWith({
    Color? background,
    Color? backgroundCompliment,
    Color? textColor,
    Color? border,
    Color? navbarBackground,
    Color? buttonGrey,
    Color? buttonPrimary,
    Color? progressBarBackground,
    Color? progressBarForeground,
  }) {
    return CustomColors(
      background: background ?? this.background,
      backgroundCompliment: backgroundCompliment ?? this.backgroundCompliment,
      textColor: textColor ?? this.textColor,
      navbarBackground: navbarBackground ?? this.navbarBackground,
      border: border ?? this.border,
      buttonGrey: buttonGrey ?? this.buttonGrey,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      progressBarBackground: progressBarBackground ?? this.progressBarBackground,
      progressBarForeground: progressBarForeground ?? this.progressBarForeground,
    );
  }

  // Controls how the properties change on theme changes
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      background: Color.lerp(background, other.background, t),
      backgroundCompliment: Color.lerp(backgroundCompliment, other.backgroundCompliment, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      border: Color.lerp(border, other.border, t),
      navbarBackground: Color.lerp(navbarBackground, other.navbarBackground, t),
      buttonGrey: Color.lerp(buttonGrey, other.buttonGrey, t),
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t),
      progressBarBackground: Color.lerp(progressBarBackground, other.progressBarBackground, t),
      progressBarForeground: Color.lerp(progressBarForeground, other.progressBarForeground, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  //   @override
  //   String toString() => 'CustomColors('
  //       'success: $success, info: $info, warning: $info, danger: $danger'
  //       ')';
}

final custDarkTheme = ThemeData.dark().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    const CustomColors(
      // general
      background: Color(0xFF252525),
      backgroundCompliment: Color(0xFF201f1e),
      textColor: Color(0xFFFFFFFF),
      border: Color.fromARGB(255, 48, 48, 48),
      // navabar
      navbarBackground: Color(0xFF252525),
      //
      buttonGrey: Color(0xff5d5d5d),
      buttonPrimary: Color(0xff006699),
      // progress_bar
      progressBarBackground: Color.fromARGB(255, 27, 20, 20),
      progressBarForeground: Color.fromARGB(255, 83, 109, 209),
    )
  ],
  useMaterial3: true,
  primaryTextTheme: ThemeData.dark().textTheme.apply(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
    bodyMedium: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
);

final custLightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    const CustomColors(
      // general
      background: Color(0xFFF8F8F8),
      backgroundCompliment: Color(0xFFfcfcfc),
      textColor: Color(0xFF000000),
      border: Color.fromARGB(255, 214, 214, 214),
      // navabar
      navbarBackground: Color(0xFFf8f8f8),
      //
      buttonGrey: Color(0xff5d5d5d),
      buttonPrimary: Color(0xff006699),
      // progress_bar
      progressBarBackground: Color(0xFFF1F1F1),
      progressBarForeground: Color(0xFF254CFF),
    )
  ],
  useMaterial3: true,
  primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
  scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
);

///

// class ThemeToggleButton extends ConsumerWidget {
//   const ThemeToggleButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return TextButton(
//       onPressed: () {
//         // print("Toggle Theme");
//         ref.read(themeProvider.notifier).toggleTheme();
//       },
//       child: const Text("Toggle Theme"),
//     );
//   }
// }
