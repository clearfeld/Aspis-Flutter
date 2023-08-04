import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleStruct {
  String? languageNameFullEnglish;
  String? languageNameCode;

  LocaleStruct(this.languageNameFullEnglish, this.languageNameCode);
}

enum ELocales { english, french }

final englishLocale = LocaleStruct("English", "en");

final Map<ELocales, LocaleStruct> localesSupported = {
  ELocales.english: englishLocale,
  ELocales.french: LocaleStruct("French", "fr")
};

final localeProvider = StateNotifierProvider<LocaleManager, LocaleStruct>((ref) {
  return LocaleManager();
});

class LocaleManager extends StateNotifier<LocaleStruct> {
  LocaleManager() : super(englishLocale);

  void setLocale(LocaleStruct arg) {
    state = arg;
  }

//   void toggleTheme() {
//     if (state == ThemeMode.dark) {
//       state = ThemeMode.light;
//     } else {
//       state = ThemeMode.dark;
//     }
//   }

//   void setLightMode() {
//     state = ThemeMode.light;
//   }

//   void setDarkMode() {
//     state = ThemeMode.dark;
//   }
}
