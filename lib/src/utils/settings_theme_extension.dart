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
    );
  }

  static const defaultLightTheme = SettingsTheme(
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

  static const defaultDarkTheme = SettingsTheme(
    platform: DevicePlatform.android,
    settingsListBackground: Color.fromRGBO(240, 240, 240, 1),
    leadingIconsColor: Color.fromARGB(255, 197, 197, 197),
    tileDescriptionTextColor: Color.fromARGB(255, 198, 198, 198),
    tileHighlightColor: Color.fromARGB(255, 46, 46, 46),
    titleTextColor: Color.fromRGBO(211, 227, 253, 1),
    settingsTileTextColor: Color.fromARGB(255, 240, 240, 240),
    inactiveTitleColor: Color.fromARGB(255, 118, 117, 122),
    inactiveSubtitleColor: Color.fromARGB(255, 71, 70, 74),
  );
}
