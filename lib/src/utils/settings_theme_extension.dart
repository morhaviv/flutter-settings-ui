import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';

@immutable
class SettingsTheme extends ThemeExtension<SettingsTheme> {
  const SettingsTheme({
    required this.platform,
    this.settingsListBackground,
    this.trailingTextColor,
    this.leadingIconsColor,
    this.settingsSectionBackground,
    this.dividerColor,
    this.tileDescriptionTextColor,
    this.tileHighlightColor,
    this.titleTextColor,
    this.settingsTileTextColor,
    this.inactiveTitleColor,
    this.inactiveSubtitleColor,
    this.disabledOverlayColor,
  });

  final DevicePlatform platform;
  final Color? settingsListBackground;
  final Color? trailingTextColor;
  final Color? leadingIconsColor;
  final Color? settingsSectionBackground;
  final Color? dividerColor;
  final Color? tileDescriptionTextColor;
  final Color? tileHighlightColor;
  final Color? titleTextColor;
  final Color? settingsTileTextColor;
  final Color? inactiveTitleColor;
  final Color? inactiveSubtitleColor;
  final Color? disabledOverlayColor;

  @override
  ThemeExtension<SettingsTheme> copyWith({
    DevicePlatform? platform,
    Color? settingsListBackground,
    Color? trailingTextColor,
    Color? leadingIconsColor,
    Color? settingsSectionBackground,
    Color? dividerColor,
    Color? tileDescriptionTextColor,
    Color? tileHighlightColor,
    Color? titleTextColor,
    Color? settingsTileTextColor,
    Color? inactiveTitleColor,
    Color? inactiveSubtitleColor,
    Color? disabledOverlayColor,
  }) {
    return SettingsTheme(
      platform: platform ?? this.platform,
      settingsListBackground: settingsListBackground ?? this.settingsListBackground,
      trailingTextColor: trailingTextColor ?? this.trailingTextColor,
      leadingIconsColor: leadingIconsColor ?? this.leadingIconsColor,
      settingsSectionBackground: settingsSectionBackground ?? this.settingsSectionBackground,
      dividerColor: dividerColor ?? this.dividerColor,
      tileDescriptionTextColor: tileDescriptionTextColor ?? this.tileDescriptionTextColor,
      tileHighlightColor: tileHighlightColor ?? this.tileHighlightColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      settingsTileTextColor: settingsTileTextColor ?? this.settingsTileTextColor,
      inactiveTitleColor: inactiveTitleColor ?? this.inactiveTitleColor,
      inactiveSubtitleColor: inactiveSubtitleColor ?? this.inactiveSubtitleColor,
      disabledOverlayColor: disabledOverlayColor ?? this.disabledOverlayColor,
    );
  }

  @override
  ThemeExtension<SettingsTheme> lerp(ThemeExtension<SettingsTheme>? other, double t) {
    if (other is! SettingsTheme) {
      return this;
    }
    return SettingsTheme(
      platform: platform,
      settingsListBackground: Color.lerp(settingsListBackground, other.settingsListBackground, t),
      trailingTextColor: Color.lerp(trailingTextColor, other.trailingTextColor, t),
      leadingIconsColor: Color.lerp(leadingIconsColor, other.leadingIconsColor, t),
      settingsSectionBackground: Color.lerp(settingsSectionBackground, other.settingsSectionBackground, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      tileDescriptionTextColor: Color.lerp(tileDescriptionTextColor, other.tileDescriptionTextColor, t),
      tileHighlightColor: Color.lerp(tileHighlightColor, other.tileHighlightColor, t),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      settingsTileTextColor: Color.lerp(settingsTileTextColor, other.settingsTileTextColor, t),
      inactiveTitleColor: Color.lerp(inactiveTitleColor, other.inactiveTitleColor, t),
      inactiveSubtitleColor: Color.lerp(inactiveSubtitleColor, other.inactiveSubtitleColor, t),
      disabledOverlayColor: Color.lerp(disabledOverlayColor, other.disabledOverlayColor, t),
    );
  }

  static SettingsTheme getTheme(Brightness brightness, DevicePlatform platform) {
    switch (brightness) {
      case Brightness.dark:
        switch (platform) {
          case DevicePlatform.android:
          case DevicePlatform.fuchsia:
          case DevicePlatform.linux:
            return defaultAndroidDarkTheme;
          case DevicePlatform.iOS:
          case DevicePlatform.macOS:
          case DevicePlatform.windows:
            return defaultIosDarkTheme;
          case DevicePlatform.web:
            return defaultWebDarkTheme;
          case DevicePlatform.device:
            throw Exception(
              'You can\'t use the DevicePlatform.device in this context. '
                  'Incorrect platform: ThemeProvider.getTheme',
            );
        }
        break;
      case Brightness.light:
        switch (platform) {
          case DevicePlatform.android:
          case DevicePlatform.fuchsia:
          case DevicePlatform.linux:
            return defaultAndroidLightTheme;
          case DevicePlatform.iOS:
          case DevicePlatform.macOS:
          case DevicePlatform.windows:
            return defaultIosLightTheme;
          case DevicePlatform.web:
            return defaultWebLightTheme;
          case DevicePlatform.device:
            throw Exception(
              'You can\'t use the DevicePlatform.device in this context. '
                  'Incorrect platform: ThemeProvider.getTheme',
            );
        }
        break;
    }
  }

  static const defaultAndroidLightTheme = SettingsTheme(
    platform: DevicePlatform.android,
    settingsListBackground: Color.fromRGBO(240, 240, 240, 1),
    leadingIconsColor: Color.fromARGB(255, 70, 70, 70),
    tileDescriptionTextColor: Color.fromARGB(255, 70, 70, 70),
    tileHighlightColor: Color.fromARGB(255, 220, 220, 220),
    titleTextColor: Color.fromRGBO(11, 87, 208, 1),
    settingsTileTextColor: Color.fromARGB(255, 27, 27, 27),
    inactiveTitleColor: Color.fromARGB(255, 146, 144, 148),
    inactiveSubtitleColor: Color.fromARGB(255, 197, 196, 201),
  );

  static const defaultAndroidDarkTheme = SettingsTheme(
    platform: DevicePlatform.android,
    settingsListBackground: Color.fromRGBO(27, 27, 27, 1),
    leadingIconsColor: Color.fromARGB(255, 197, 197, 197),
    tileDescriptionTextColor: Color.fromARGB(255, 198, 198, 198),
    tileHighlightColor: Color.fromARGB(255, 46, 46, 46),
    titleTextColor: Color.fromRGBO(211, 227, 253, 1),
    settingsTileTextColor: Color.fromARGB(255, 240, 240, 240),
    inactiveTitleColor: Color.fromARGB(255, 118, 117, 122),
    inactiveSubtitleColor: Color.fromARGB(255, 71, 70, 74),
  );

  static const defaultIosLightTheme = SettingsTheme(
    platform: DevicePlatform.iOS,
    settingsListBackground: Color.fromRGBO(242, 242, 247, 1),
    settingsSectionBackground: CupertinoColors.white,
    titleTextColor: Color.fromRGBO(109, 109, 114, 1),
    settingsTileTextColor: CupertinoColors.black,
    dividerColor: Color.fromARGB(255, 238, 238, 238),
    trailingTextColor: Color.fromARGB(255, 138, 138, 142),
    tileHighlightColor: Color.fromARGB(255, 209, 209, 214),
    leadingIconsColor: CupertinoColors.inactiveGray,
    inactiveTitleColor: CupertinoColors.inactiveGray,
    inactiveSubtitleColor: CupertinoColors.inactiveGray,
  );

  static const defaultIosDarkTheme = SettingsTheme(
    platform: DevicePlatform.iOS,
    settingsListBackground: CupertinoColors.black,
    settingsSectionBackground: Color.fromARGB(255, 28, 28, 30),
    titleTextColor: CupertinoColors.systemGrey,
    settingsTileTextColor: CupertinoColors.white,
    dividerColor: Color.fromARGB(255, 40, 40, 42),
    trailingTextColor: Color.fromARGB(255, 152, 152, 159),
    tileHighlightColor: Color.fromARGB(255, 58, 58, 60),
    leadingIconsColor: CupertinoColors.inactiveGray,
    inactiveTitleColor: CupertinoColors.inactiveGray,
    inactiveSubtitleColor: CupertinoColors.inactiveGray,
  );

  static const defaultWebLightTheme = SettingsTheme(
    platform: DevicePlatform.web,
    tileHighlightColor: Color.fromARGB(255, 220, 220, 220),
    settingsListBackground: Color.fromRGBO(240, 240, 240, 1),
    titleTextColor: Color.fromRGBO(11, 87, 208, 1),
    settingsSectionBackground: CupertinoColors.white,
    settingsTileTextColor: Color.fromARGB(255, 27, 27, 27),
    tileDescriptionTextColor: Color.fromARGB(255, 70, 70, 70),
    leadingIconsColor: Color.fromARGB(255, 70, 70, 70),
    disabledOverlayColor: Color.fromRGBO(255, 255, 255, 0.65),
    inactiveTitleColor: Color.fromARGB(255, 146, 144, 148),
    inactiveSubtitleColor: Color.fromARGB(255, 197, 196, 201),
  );

  static const defaultWebDarkTheme = SettingsTheme(
    platform: DevicePlatform.web,
    tileHighlightColor: Color.fromARGB(255, 46, 46, 46),
    settingsListBackground: Color.fromRGBO(32, 33, 36, 1),
    titleTextColor: Color.fromRGBO(232, 234, 237, 1),
    settingsSectionBackground: Color(0xFF292a2d),
    settingsTileTextColor: Color.fromARGB(232, 234, 237, 240),
    tileDescriptionTextColor: Color.fromARGB(154, 160, 166, 198),
    leadingIconsColor: Color.fromARGB(255, 197, 197, 197),
    inactiveTitleColor: Color.fromARGB(255, 118, 117, 122),
    inactiveSubtitleColor: Color.fromARGB(255, 71, 70, 74),
  );
}