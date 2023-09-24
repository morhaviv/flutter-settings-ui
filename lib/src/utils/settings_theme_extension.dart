import 'package:flutter/material.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';

@immutable
class SettingsTheme extends ThemeExtension<SettingsTheme> {
  const SettingsTheme({
    required this.platform,
    required this.settingsListBackground,
    required this.trailingTextColor,
    required this.leadingIconsColor,
    required this.settingsSectionBackground,
    required this.dividerColor,
    required this.tileDescriptionTextColor,
    required this.tileHighlightColor,
    required this.titleTextColor,
    required this.settingsTileTextColor,
    required this.inactiveTitleColor,
    required this.inactiveSubtitleColor,
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

  static const defaultTheme = SettingsTheme(
    platform: DevicePlatform.android,
    settingsListBackground: Colors.white,
    trailingTextColor: Colors.black,
    leadingIconsColor: Colors.grey,
    settingsSectionBackground: Colors.grey,
    dividerColor: Colors.grey,
    tileDescriptionTextColor: Colors.grey,
    tileHighlightColor: Colors.blue,
    titleTextColor: Colors.black,
    settingsTileTextColor: Colors.black,
    inactiveTitleColor: Colors.grey,
    inactiveSubtitleColor: Colors.grey,
  );
}
