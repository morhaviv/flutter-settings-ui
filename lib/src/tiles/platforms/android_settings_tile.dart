import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/utils/settings_theme_extension.dart';

class AndroidSettingsTile extends StatelessWidget {
  const AndroidSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
    required this.maxValue,
    required this.sliderDivisions,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(dynamic value)? onToggle;
  final Widget? value;
  final dynamic initialValue;
  final bool enabled;
  final Widget? trailing;
  final Color? activeSwitchColor;
  final double? maxValue;
  final double? sliderDivisions;

  @override
  Widget build(BuildContext context) {
    SettingsTheme? theme = Theme.of(context).extension<SettingsTheme>();
    if (theme == null) {
      theme = SettingsTheme.getTheme(Brightness.light, PlatformUtils.detectPlatform(context));
    }
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    final cantShowAnimation = tileType == SettingsTileType.switchTile ? onToggle == null && onPressed == null : onPressed == null;
    Widget? tileTypeWidget;
    EdgeInsetsDirectional trailingPadding;
    Axis flexDirection = Axis.horizontal;
    double width = MediaQuery.of(context).size.width;

    switch (tileType) {
      case SettingsTileType.simpleTile:
        flexDirection = Axis.horizontal;
        trailingPadding = const EdgeInsetsDirectional.only(start: 16, end: 16);
        break;
      case SettingsTileType.switchTile:
        flexDirection = Axis.horizontal;
        tileTypeWidget = Switch(
          value: initialValue,
          activeColor: enabled ? activeSwitchColor : theme.inactiveTitleColor ?? Color.fromRGBO(138, 180, 248, 1.0),
          onChanged: onToggle,
        );
        trailingPadding = const EdgeInsetsDirectional.only(end: 8);
        break;
      case SettingsTileType.navigationTile:
        flexDirection = Axis.horizontal;
        trailingPadding = const EdgeInsetsDirectional.only(start: 16, end: 16);
        break;
      case SettingsTileType.sliderTile:
        if (width > theme.maxSliderWidth!) {
          flexDirection = Axis.horizontal;
        } else {
          flexDirection = Axis.vertical;
        }

        tileTypeWidget = Slider(value: initialValue.toDouble(), max: 10, divisions: 10, label: initialValue.toString(), onChanged: onToggle);
        // trailingPadding = const EdgeInsetsDirectional.only(top: 16, bottom: 8);
        trailingPadding = const EdgeInsetsDirectional.only(start: 16, end: 16);

        break;
    }

    Widget tile = IgnorePointer(
      ignoring: !enabled,
      child: Material(
        child: InkWell(
          onTap: cantShowAnimation
              ? null
              : () {
            if (tileType == SettingsTileType.switchTile) {
              onToggle?.call(!initialValue);
            } else {
              onPressed?.call(context);
            }
          },
          highlightColor: theme.tileHighlightColor,
          child: Container(
            child: Flex(
              direction: flexDirection,
              children: [
                Row(
                  children: [
                    if (leading != null)
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 24,
                          // top: (width > MAX_WIDTH && tileType == SettingsTileType.sliderTile) ? 5 : 0,
                        ),
                        child: IconTheme(
                          data: IconTheme.of(context).copyWith(color: this.enabled ? theme.leadingIconsColor : theme.inactiveTitleColor),
                          child: leading!,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 24,
                        end: 24,
                        bottom: 19 * scaleFactor,
                        top: 19 * scaleFactor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                              style: TextStyle(
                                color: this.enabled ? theme.settingsTileTextColor : theme.inactiveTitleColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              child: title ?? Container()),
                          if (value != null)
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: this.enabled ? theme.tileDescriptionTextColor : theme.inactiveTitleColor,
                                ),
                                child: value!,
                              ),
                            )
                          else if (description != null)
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: this.enabled ? theme.tileDescriptionTextColor : theme.inactiveTitleColor,
                                ),
                                child: description!,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (tileType != SettingsTileType.sliderTile || (tileType == SettingsTileType.sliderTile && width > theme.maxSliderWidth!))
                  Spacer(),
                if (trailing != null && (tileType == SettingsTileType.switchTile || tileType == SettingsTileType.sliderTile))
                  Padding(
                    padding: trailingPadding,
                    child: Flex(
                      direction: flexDirection,
                      children: [
                        trailing!,
                        tileTypeWidget!,
                      ],
                    ),
                  )
                else if (tileType == SettingsTileType.switchTile || tileType == SettingsTileType.sliderTile)
                  Padding(padding: trailingPadding, child: tileTypeWidget!)
                else if (trailing != null)
                    Padding(
                      padding: trailingPadding,
                      child: trailing!,
                    ),
              ],
            ),
          ),
        ),
      ),
    );

    if (enabled) {
      return tile;
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.65), BlendMode.srcATop),
      child: tile,
    );
  }
}
