import 'package:flutter/material.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/tiles/platforms/android_settings_tile.dart';
import 'package:settings_ui/src/tiles/platforms/ios_settings_tile.dart';
import 'package:settings_ui/src/tiles/platforms/web_settings_tile.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme_extension.dart';

enum SettingsTileType { simpleTile, switchTile, navigationTile, sliderTile }

class SettingsTile extends AbstractSettingsTile {
  SettingsTile({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    onChanged = null;
    onChangedStart = null;
    onChangedEnd = null;
    initialValue = null;
    activeSwitchColor = null;
    maxValue = null;
    minValue = null;
    sliderDivisions = null;
    tileType = SettingsTileType.simpleTile;
  }

  SettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    onChanged = null;
    onChangedStart = null;
    onChangedEnd = null;
    initialValue = null;
    activeSwitchColor = null;
    maxValue = null;
    minValue = null;
    sliderDivisions = null;
    tileType = SettingsTileType.navigationTile;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onChanged,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    value = null;
    maxValue = null;
    minValue = null;
    onChangedStart = null;
    onChangedEnd = null;
    sliderDivisions = null;
    tileType = SettingsTileType.switchTile;
  }


  SettingsTile.sliderTile({
    required this.initialValue,
    required this.onChanged,
    this.onChangedStart,
    this.onChangedEnd,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.maxValue,
    this.minValue,
    this.sliderDivisions,
    Key? key,
  }) : super(key: key) {
    value = null;
    tileType = SettingsTileType.sliderTile;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  final Widget? trailing;

  /// The widget at the center of the tile
  final Widget title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  /// A function that is called by tap on a tile
  final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(dynamic value)? onChanged;
  late final Function(dynamic value)? onChangedStart;
  late final Function(dynamic value)? onChangedEnd;
  late final SettingsTileType tileType;
  late final dynamic initialValue;
  late final bool enabled;
  late final double? maxValue;
  late final double? minValue;
  late final int? sliderDivisions;

  @override
  Widget build(BuildContext context) {
    SettingsTheme? theme = Theme.of(context).extension<SettingsTheme>();
    if (theme == null) {
      theme = SettingsTheme.getTheme(Brightness.light, PlatformUtils.detectPlatform(context));
    }

    switch (theme.platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return AndroidSettingsTile(
          description: description,
          onPressed: onPressed,
          onChanged: onChanged,
          onChangedStart: onChangedStart,
          onChangedEnd: onChangedEnd,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: enabled,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
          trailing: trailing,
          maxValue: maxValue,
          minValue: minValue,
          sliderDivisions: sliderDivisions,
        );
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return IOSSettingsTile(
          description: description,
          onPressed: onPressed,
          onChanged: onChanged,
          onChangedStart: onChangedStart,
          onChangedEnd: onChangedEnd,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          trailing: trailing,
          enabled: enabled,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
          maxValue: maxValue,
          minValue: minValue,
          sliderDivisions: sliderDivisions,
        );
      case DevicePlatform.web:
        return WebSettingsTile(
          description: description,
          onPressed: onPressed,
          onChanged: onChanged,
          onChangedStart: onChangedStart,
          onChangedEnd: onChangedEnd,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: enabled,
          trailing: trailing,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
          maxValue: maxValue,
          minValue: minValue,
          sliderDivisions: sliderDivisions,
        );
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsTile.build',
        );
    }
  }
}
