import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = context.watch<HomePageViewModel>();

    return Container(
      child: SettingsList(
        sections: [
          SettingsSection(
            title: 'Common',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Phone number',
                leading: Icon(Icons.phone),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Email',
                leading: Icon(Icons.email),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Sign Out',
                leading: Icon(Icons.logout),
                onTap: () =>homeScreenProvider.signOut(),
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Options',
            tiles: [
              SettingsTile(
                title: 'Screen',
                subtitle: 'Home and lock screen',
                onTap: () {},
              ),
              SettingsTile(
                title: 'Source',
                onTap: () {},
              ),
              SettingsTile(
                title: 'Theme',
                subtitle: 'System',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'About',
            tiles: [
              SettingsTile(
                title: 'Recommend',
                subtitle: 'Share this app with friends and family',
                onTap: () {},
              ),
              SettingsTile(
                title: 'Rate App',
                subtitle: 'Leave a review on the Google Play Store',
                onTap: () {},
              ),
              SettingsTile(
                title: 'App Version',
                subtitle: 'alpha',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
