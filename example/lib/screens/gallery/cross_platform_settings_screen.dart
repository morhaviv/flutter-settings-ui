import 'package:example/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class CrossPlatformSettingsScreen extends StatefulWidget {
  const CrossPlatformSettingsScreen();

  @override
  State<CrossPlatformSettingsScreen> createState() =>
      _CrossPlatformSettingsScreenState();
}

class _CrossPlatformSettingsScreenState
    extends State<CrossPlatformSettingsScreen> {
  bool useCustomTheme = false;
  double sliderCount = 3;



  final platformsMap = <DevicePlatform, String>{
    DevicePlatform.device: 'Default',
    DevicePlatform.android: 'Android',
    DevicePlatform.iOS: 'iOS',
    DevicePlatform.web: 'Web',
    DevicePlatform.fuchsia: 'Fuchsia',
    DevicePlatform.linux: 'Linux',
    DevicePlatform.macOS: 'MacOS',
    DevicePlatform.windows: 'Windows',
  };
  DevicePlatform selectedPlatform = DevicePlatform.device;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        platform: selectedPlatform,
        lightTheme: !useCustomTheme
            ? null
            : SettingsTheme.getTheme(Brightness.light, PlatformUtils.detectPlatform(context)),
        darkTheme: !useCustomTheme
            ? null
            : SettingsTheme.getTheme(Brightness.dark, PlatformUtils.detectPlatform(context)),
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.cloud_outlined),
                title: Text('Environment'),
                value: Text('Production'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.devices_other),
                title: Text('Platform'),
                onPressed: (context) async {
                  final platform = await Navigation.navigateTo<DevicePlatform>(
                    context: context,
                    style: NavigationRouteStyle.material,
                    screen: PlatformPickerScreen(
                      platform: selectedPlatform,
                      platforms: platformsMap,
                    ),
                  );

                  if (platform != null && platform is DevicePlatform) {
                    setState(() {
                      selectedPlatform = platform;
                    });
                  }
                },
                value: Text(platformsMap[selectedPlatform]!),
              ),
              SettingsTile.switchTile(
                onChanged: (value) {
                  setState(() {
                    useCustomTheme = value;
                  });
                },
                initialValue: useCustomTheme,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.phone),
                title: Text('Phone number'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.mail),
                title: Text('Email'),
                enabled: false,
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: Text('Sign out'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile(
                trailing: Text("Kaki1, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2, Kaki2",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
                value: Text("53"),
                leading: Icon(Icons.phonelink_lock),
                title: Text('Lock app in background'),
                description: Text('Do something interesting'),
              ),
              SettingsTile.switchTile(
                onChanged: (_) {},
                initialValue: true,
                leading: Icon(Icons.phonelink_lock),
                title: Text('Lock app in background'),
              ),
              SettingsTile.sliderTile(
                onChanged: (value) {
                  setState(() {
                    sliderCount = value;
                  });
                },
                enabled: false,
                initialValue: sliderCount,
                maxValue: 10,
                trailing: Text("Test text"),
                sliderDivisions: 10,
                leading: Icon(Icons.phonelink_lock),
                title: Text('Lock app in background'),
              ),
              SettingsTile.sliderTile(
                onChanged: (value) {
                  setState(() {
                    sliderCount = value;
                  });
                },
                initialValue: sliderCount,
                maxValue: 10,
                trailing: Text("Test text"),
                sliderDivisions: 10,
                leading: Icon(Icons.phonelink_lock),
                title: Text('Lock app in background'),
              ),
              SettingsTile.switchTile(
                onChanged: (_) {},
                initialValue: true,
                leading: Icon(Icons.fingerprint),
                title: Text('Use fingerprint'),
                description: Text(
                  'Allow application to access stored fingerprint IDs',
                  softWrap: true,
                ),
              ),
              SettingsTile.switchTile(
                onChanged: (_) {},
                initialValue: true,
                leading: Icon(Icons.lock),
                title: Text('Change password'),
              ),
              SettingsTile.switchTile(
                onChanged: (_) {},
                initialValue: true,
                leading: Icon(Icons.notifications_active),
                title: Text('Enable notifications'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Misc'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.description),
                title: Text('Terms of Service'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.collections_bookmark),
                title: Text('Open source license'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlatformPickerScreen extends StatelessWidget {
  const PlatformPickerScreen({
    required this.platform,
    required this.platforms,
  });

  final DevicePlatform platform;
  final Map<DevicePlatform, String> platforms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Platforms')),
      body: SettingsList(
        platform: platform,
        sections: [
          SettingsSection(
            title: Text('Select the platform you want'),
            tiles: platforms.keys.map((e) {
              final platform = platforms[e];

              return SettingsTile(
                title: Text(platform!),
                onPressed: (_) {
                  Navigator.of(context).pop(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
