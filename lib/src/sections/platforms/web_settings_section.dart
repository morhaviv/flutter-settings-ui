import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/utils/settings_theme_extension.dart';

class WebSettingsSection extends StatelessWidget {
  const WebSettingsSection({
    required this.tiles,
    required this.margin,
    required this.title,
    Key? key,
  }) : super(key: key);

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return buildSectionBody(context);
  }

  Widget buildSectionBody(BuildContext context) {
    SettingsTheme? theme = Theme.of(context).extension<SettingsTheme>();
    if (theme == null) {
      theme = SettingsTheme.getTheme(Brightness.light, PlatformUtils.detectPlatform(context));
    }
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    print("margin");
    print(margin);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              height: 65 * scaleFactor,
              padding: EdgeInsetsDirectional.only(
                bottom: 5 * scaleFactor,
                start: 6,
                top: 40 * scaleFactor,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: theme.titleTextColor,
                  fontSize: 15,
                ),
                child: title!,
              ),
            ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            color: theme.settingsSectionBackground,
            child: buildTileList(),
          ),
        ],
      ),
    );
  }

  Widget buildTileList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return tiles[index];
        // return Text("sadndsauidsniudsanuidsua asu duias dhasi huidas hsuaidsidah sadiuuhi sdaud sahisu dah dsahuisaduihsdaiuh sdaui sadius dahuidsa hiuds ahuisda huasid husad husa dihsda uihsdaui dahsiusad ");
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0,
          thickness: 1,
        );
      },
    );
  }
}
