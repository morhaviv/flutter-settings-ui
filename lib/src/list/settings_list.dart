import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';
import 'package:settings_ui/src/utils/settings_theme_extension.dart';
import 'package:settings_ui/src/utils/theme_provider.dart';

enum ApplicationType {
  /// Use this parameter is you are using the MaterialApp
  material,

  /// Use this parameter is you are using the CupertinoApp
  cupertino,

  /// Use this parameter is you are using the MaterialApp for Android
  /// and the CupertinoApp for iOS.
  both,
}

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.platform,
    this.lightTheme,
    this.darkTheme,
    this.brightness,
    this.contentPadding,
    this.applicationType = ApplicationType.material,
    Key? key,
  }) : super(key: key);

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final DevicePlatform? platform;
  final SettingsTheme? lightTheme;
  final SettingsTheme? darkTheme;
  final Brightness? brightness;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;
  final ApplicationType applicationType;

  @override
  Widget build(BuildContext context) {
    DevicePlatform platform;
    if (this.platform == null || this.platform == DevicePlatform.device) {
      platform = PlatformUtils.detectPlatform(context);
    } else {
      platform = this.platform!;
    }

    SettingsTheme? themeData = Theme.of(context).extension<SettingsTheme>();

    switch (brightness) {
      case Brightness.dark:
        if (this.darkTheme != null) {
          themeData = this.darkTheme!;
        }
        break;
      case Brightness.light:
        if (this.lightTheme != null) {
          themeData = this.lightTheme!;
        }
        break;

      case null:
        if (themeData != null) {
          break;
        }
        if (this.lightTheme != null) {
          themeData = this.lightTheme!;
          break;
        }
        if (this.darkTheme != null) {
          themeData = this.darkTheme!;
          break;
        }
        break;
    }

    if (themeData == null) {
      themeData = SettingsTheme.defaultAndroidLightTheme;
    }

    return Container(
      color: themeData.settingsListBackground,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: sections.length,
        padding: contentPadding ?? calculateDefaultPadding(platform, context),
        itemBuilder: (BuildContext context, int index) {
          print(MediaQuery.of(context).size.width);
          print(calculateDefaultPadding(platform, context));
          return sections[index];
        },
      ),
    );
  }

  EdgeInsets calculateDefaultPadding(DevicePlatform platform, BuildContext context) {
    if (MediaQuery.of(context).size.width > 810) {
      double padding = (MediaQuery.of(context).size.width - 810) / 2;
      switch (platform) {
        case DevicePlatform.android:
        case DevicePlatform.fuchsia:
        case DevicePlatform.linux:
        case DevicePlatform.iOS:
        case DevicePlatform.macOS:
        case DevicePlatform.windows:
          return EdgeInsets.symmetric(horizontal: padding);
        case DevicePlatform.web:
          return EdgeInsets.symmetric(vertical: 20, horizontal: padding);
        case DevicePlatform.device:
          throw Exception(
            'You can\'t use the DevicePlatform.device in this context. '
            'Incorrect platform: SettingsList.calculateDefaultPadding',
          );
        default:
          return EdgeInsets.symmetric(
            horizontal: padding,
          );
      }
    }
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return EdgeInsets.symmetric(vertical: 0);
      case DevicePlatform.web:
        return EdgeInsets.symmetric(vertical: 20);
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsList.calculateDefaultPadding',
        );
    }
  }

  Brightness calculateBrightness(BuildContext context) {
    final materialBrightness = Theme.of(context).brightness;
    final cupertinoBrightness = CupertinoTheme.of(context).brightness ?? MediaQuery.of(context).platformBrightness;

    switch (applicationType) {
      case ApplicationType.material:
        return materialBrightness;
      case ApplicationType.cupertino:
        return cupertinoBrightness;
      case ApplicationType.both:
        return platform != DevicePlatform.iOS ? materialBrightness : cupertinoBrightness;
    }
  }
}
