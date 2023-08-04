import 'package:aspis/locale_provider.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aspis/components/flat_setting.dart';

enum ColorTheme { dark, light }

enum Language { en, fr }

class PageSettings extends ConsumerStatefulWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  ConsumerState<PageSettings> createState() => _PageSettingsState();
}

class _PageSettingsState extends ConsumerState<PageSettings> {
  ColorTheme? _theme = ColorTheme.dark;
  LocaleStruct? _lanugage = null;

  bool minOnCopy = false;
  bool copyWhenTapped = false;
  bool encrypt = false;
  bool separatePw = false;
  bool screenSecurity = false;
  bool tapToReveal = false;
  bool backupKeys = false;
  bool cloudBackups = false;

  bool backButtonPress = false;
  bool appMinimized = false;
  bool deviceLocked = false;

  @override
  Widget build(BuildContext context) {
    final LocaleStruct lm = ref.watch(localeProvider);
    final customColors = Theme.of(context).extension<CustomColors>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.page_settings__settings ?? "",
        ),
        elevation: 0,
        backgroundColor: customColors!.navbarBackground,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)?.page_settings__locale ?? "",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                child: FlatSetting(
                  settingNameText: AppLocalizations.of(context)?.page_settings__language ?? "",
                  descriptionNameText:
                      lm.languageNameFullEnglish ?? "", // '${_theme.toString().substring(11)}'
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)
                                      ?.page_settings__select_your_desired_theme ??
                                  "",
                            ),
                            content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                              return Column(children: [
                                ListTile(
                                  title: const Text(
                                      // localesSupported[ELocales.english].languageNameFullEnglish ?? ""
                                      "English"),
                                  leading: Radio<LocaleStruct>(
                                    value: localesSupported[ELocales.english] ?? englishLocale,
                                    groupValue: _lanugage,
                                    onChanged: (LocaleStruct? value) {
                                      ref
                                          .read(localeProvider.notifier)
                                          .setLocale(value ?? englishLocale);
                                      setState(() {
                                        _lanugage = value;
                                      });
                                    },
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                ),
                                ListTile(
                                  title: const Text("French"),
                                  leading: Radio<LocaleStruct>(
                                    value: localesSupported[ELocales.french] ?? englishLocale,
                                    groupValue: _lanugage,
                                    onChanged: (LocaleStruct? value) {
                                      ref
                                          .read(localeProvider.notifier)
                                          .setLocale(value ?? englishLocale);
                                      setState(() {
                                        _lanugage = value;
                                      });
                                    },
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                ),
                              ]);
                            }),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(context)?.page_settings__okay ?? "",
                                ),
                                onPressed: () {
                                  // setState(() => currentValue = initialValue);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            scrollable: true);
                      });
                },
              ),

              //

              //   const Text(
              //     "Appearance",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   InkWell(
              //     child: FlatSetting(
              //         settingNameText: 'Theme',
              //         descriptionNameText: '${_theme.toString().substring(11)} Theme'),
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //                 title: const Text("Select your desired theme"),
              //                 content: StatefulBuilder(
              //                     builder: (BuildContext context, StateSetter setState) {
              //                   return Column(children: [
              //                     ListTile(
              //                       title: const Text("Dark Mode"),
              //                       leading: Radio<ColorTheme>(
              //                         value: ColorTheme.dark,
              //                         groupValue: _theme,
              //                         onChanged: (ColorTheme? value) {
              //                           setState(() {
              //                             _theme = value;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                     ListTile(
              //                       title: const Text("Light Mode"),
              //                       leading: Radio<ColorTheme>(
              //                         value: ColorTheme.light,
              //                         groupValue: _theme,
              //                         onChanged: (ColorTheme? value) {
              //                           setState(() {
              //                             _theme = value;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                   ]);
              //                 }),
              //                 contentPadding:
              //                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              //                 actions: <Widget>[
              //                   ElevatedButton(
              //                     child: const Text('Okay'),
              //                     onPressed: () {
              //                       // setState(() => currentValue = initialValue);
              //                       Navigator.of(context).pop();
              //                     },
              //                   ),
              //                 ],
              //                 scrollable: true);
              //           });
              //     },
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   InkWell(
              //     //Language {engUsa, engCad, engEb, engPir}
              //     child: FlatSetting(settingNameText: 'Language', descriptionNameText: 'English'),
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //                 title: const Text("Select your desired language"),
              //                 content: StatefulBuilder(
              //                     builder: (BuildContext context, StateSetter setState) {
              //                   return Column(children: [
              //                     ListTile(
              //                       title: const Text("English"),
              //                       leading: Radio<Language>(
              //                         value: Language.en,
              //                         groupValue: _lanugage,
              //                         onChanged: (Language? value) {
              //                           setState(() {
              //                             _lanugage = value;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                     ListTile(
              //                       title: const Text("French"),
              //                       leading: Radio<Language>(
              //                         value: Language.fr,
              //                         groupValue: _lanugage,
              //                         onChanged: (Language? value) {
              //                           setState(() {
              //                             _lanugage = value;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                   ]);
              //                 }),
              //                 contentPadding:
              //                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              //                 actions: <Widget>[
              //                   ElevatedButton(
              //                     child: const Text('Okay'),
              //                     onPressed: () {
              //                       // setState(() => currentValue = initialValue);
              //                       Navigator.of(context).pop();
              //                     },
              //                   ),
              //                 ],
              //                 scrollable: true);
              //           });
              //     },
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   const Text(
              //     "Security",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Separate Password for backup & export',
              //       descriptionNameText:
              //           "If enabled, the password that is used to unlock the app can't be used to decrypt backups and exports",
              //       showSwitch: true,
              //       switchValue: separatePw),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Screen Security',
              //       descriptionNameText: 'Block screenshots and captures within the app',
              //       showSwitch: true,
              //       switchValue: screenSecurity),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Tap to Reveal',
              //       descriptionNameText: 'Tokens will be hidden until tapped.',
              //       showSwitch: true,
              //       switchValue: tapToReveal),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //     settingNameText: 'Timeout for Tap to Reveal',
              //     descriptionNameText: 'Disabled',
              //     disabled: true,
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   InkWell(
              //     child: FlatSetting(
              //         settingNameText: 'Auto Lock',
              //         descriptionNameText: 'Determine when the app is locked'),
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //                 title: const Text("Automatically lock Aegis when"),
              //                 content: StatefulBuilder(
              //                     builder: (BuildContext context, StateSetter setState) {
              //                   return Column(children: [
              //                     ListTile(
              //                       title: const Text("The back button is pressed"),
              //                       leading: Checkbox(
              //                         value: backButtonPress,
              //                         onChanged: (bool? value) {
              //                           setState(() {
              //                             backButtonPress = value!;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                     ListTile(
              //                       title: const Text("The app is minimized"),
              //                       leading: Checkbox(
              //                         value: appMinimized,
              //                         onChanged: (bool? value) {
              //                           setState(() {
              //                             appMinimized = value!;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                     ListTile(
              //                       title: const Text("The device is locked"),
              //                       leading: Checkbox(
              //                         value: deviceLocked,
              //                         onChanged: (bool? value) {
              //                           setState(() {
              //                             deviceLocked = value!;
              //                           });
              //                         },
              //                       ),
              //                       contentPadding:
              //                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //                     ),
              //                   ]);
              //                 }),
              //                 contentPadding:
              //                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              //                 actions: <Widget>[
              //                   ElevatedButton(
              //                     child: const Text('Okay'),
              //                     onPressed: () {
              //                       // setState(() => currentValue = initialValue);
              //                       Navigator.of(context).pop();
              //                     },
              //                   ),
              //                 ],
              //                 scrollable: true);
              //           });
              //     },
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   const Divider(
              //     thickness: 0.5,
              //     color: Colors.grey,
              //   ),
              //   const SizedBox(
              //     height: 5,
              //   ),
              //   const Text(
              //     "Backups",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Automatically backup keys',
              //       descriptionNameText:
              //           'Automatically creates backups of the vault on external storage when changes are made. This is only supported for encrypted vaults.',
              //       showSwitch: true,
              //       switchValue: backupKeys),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   const Divider(
              //     thickness: 0.5,
              //     color: Colors.grey,
              //   ),
              //   const SizedBox(
              //     height: 5,
              //   ),
              //   const Text(
              //     "Import & Export",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Import from file',
              //       descriptionNameText: 'Import tokens from a file'),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Import from app',
              //       descriptionNameText: 'Import tokens from an app (requires root access)'),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(settingNameText: 'Export', descriptionNameText: 'Export the vault'),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   FlatSetting(
              //       settingNameText: 'Export for Other Apps',
              //       descriptionNameText: 'Generates export QR codes compatible with other apps'),
              //   const SizedBox(
              //     height: 15,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
