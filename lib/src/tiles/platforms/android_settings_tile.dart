import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class AndroidSettingsTile extends StatelessWidget {
  const AndroidSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onChanged,
    required this.onChangedStart,
    required this.onChangedEnd,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
    required this.maxValue,
    required this.minValue,
    required this.sliderDivisions,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(dynamic value)? onChanged;
  final Function(dynamic value)? onChangedStart;
  final Function(dynamic value)? onChangedEnd;
  final Widget? value;
  final dynamic initialValue;
  final bool enabled;
  final Widget? trailing;
  final Color? activeSwitchColor;
  final double? maxValue;
  final double? minValue;
  final int? sliderDivisions;

  @override
  Widget build(BuildContext context) {
    SettingsTheme? theme = Theme.of(context).extension<SettingsTheme>();
    if (theme == null) {
      theme = SettingsTheme.getTheme(Brightness.light, PlatformUtils.detectPlatform(context));
    }
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    Color? activeSwitchColor = this.activeSwitchColor ?? theme.settingWidgetBackgroundColor;

    final cantShowAnimation = tileType == SettingsTileType.switchTile ? onChanged == null && onPressed == null : onPressed == null;
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
          onChanged: onChanged,
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

        tileTypeWidget = Slider(
          activeColor: enabled ? activeSwitchColor : theme.inactiveTitleColor ?? Color.fromRGBO(138, 180, 248, 1.0),
          value: initialValue.toDouble(),
          max: maxValue!.toDouble(),
          min: minValue!.toDouble(),
          divisions: sliderDivisions!,
          label: initialValue.toString(),
          onChanged: onChanged,
          onChangeStart: onChangedStart,
          onChangeEnd: onChangedEnd,
        );
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
                    onChanged?.call(!initialValue);
                  } else {
                    onPressed?.call(context);
                  }
                },
          highlightColor: theme.tileHighlightColor,
          child: Flex(
            mainAxisSize: flexDirection == Axis.horizontal ? MainAxisSize.max : MainAxisSize.min,
            direction: flexDirection,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: flexDirection == Axis.horizontal ? FlexFit.tight : FlexFit.loose,
                flex: flexDirection == Axis.horizontal ? 3 : 1,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
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
                      Flexible(
                        fit: FlexFit.tight,
                        // fit: flexDirection == Axis.horizontal ? FlexFit.tight : FlexFit.loose,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.only(
                            start: 24,
                            end: 24,
                            bottom: 19 * scaleFactor,
                            top: 19 * scaleFactor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: this.enabled ? theme.settingsTileTextColor : theme.inactiveTitleColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    child: title ?? Container()),
                              ),
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
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        color: this.enabled ? theme.tileDescriptionTextColor : theme.inactiveTitleColor,
                                      ),
                                      child: description!,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (trailing != null || (tileType == SettingsTileType.switchTile || tileType == SettingsTileType.sliderTile))
                Flexible(
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: flexDirection,
                    children: [
                      if (trailing != null) Flexible(child: Container(padding: trailingPadding, child: trailing!)),
                      if (tileType == SettingsTileType.switchTile || tileType == SettingsTileType.sliderTile)
                        Flexible(child: Container(padding: trailingPadding, child: tileTypeWidget!)),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );

    return tile;
  }
}
