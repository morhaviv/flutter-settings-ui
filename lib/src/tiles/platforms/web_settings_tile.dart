import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/utils/settings_theme_extension.dart';

class WebSettingsTile extends StatelessWidget {
  const WebSettingsTile({
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
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool initialValue;
  final bool enabled;
  final Widget? trailing;
  final Color? activeSwitchColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SettingsTheme>()!;
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    final cantShowAnimation = tileType == SettingsTileType.switchTile ? onToggle == null && onPressed == null : onPressed == null;

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
            child: Row(
              children: [
                if (leading != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 24,
                    ),
                    child: IconTheme(
                      data: IconTheme.of(context).copyWith(
                        color: this.enabled
                            ? theme.leadingIconsColor
                            : theme.inactiveTitleColor
                      ),
                      child: leading!,
                    ),
                  ),
                Expanded(
                  child: Padding(
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
                ),
                // if (tileType == SettingsTileType.navigationTile)
                //   Padding(
                //     padding:
                //         const EdgeInsetsDirectional.only(start: 6, end: 15),
                //     child: IconTheme(
                //       data: IconTheme.of(context)
                //           .copyWith(color: theme.themeData.leadingIconsColor),
                //       child: Icon(
                //         CupertinoIcons.chevron_forward,
                //         size: 18 * scaleFactor,
                //       ),
                //     ),
                //   ),
                if (trailing != null && tileType == SettingsTileType.switchTile)
                  Row(
                    children: [
                      trailing!,
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: Switch(
                          activeColor: enabled ? activeSwitchColor : theme.inactiveTitleColor ?? Color.fromRGBO(138, 180, 248, 1.0),
                          value: initialValue,
                          onChanged: onToggle,
                        ),
                      ),
                    ],
                  )
                else if (tileType == SettingsTileType.switchTile)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
                    child: Switch(
                      value: initialValue,
                      activeColor: enabled ? activeSwitchColor : theme.inactiveTitleColor ?? Color.fromRGBO(138, 180, 248, 1.0),
                      onChanged: onToggle,
                    ),
                  )
                else if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
