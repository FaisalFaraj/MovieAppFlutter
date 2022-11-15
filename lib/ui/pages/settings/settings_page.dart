import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../core/services/hive/hive_service.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sizer/sizer.dart';

import '../../../locator.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final formKey = GlobalKey<FormState>();
  int click_count = 0;
  final List<String> locales = ['العربية', 'English'];
  String? selected_local;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selected_local_hint =
        locator<HiveService>().settings_box!.get('locale');
    var is_darkmode = false;
    if (selected_local_hint == 'ar') {
      selected_local_hint = 'العربية';
    } else {
      selected_local_hint = 'English';
    }
    if (locator<HiveService>().settings_box!.get('theme') == 'dark') {
      is_darkmode = true;
    } else {
      is_darkmode = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SettingsList(
        darkTheme: SettingsThemeData(
          tileDescriptionTextColor: Theme.of(context).colorScheme.onPrimary,
        ),
        lightTheme: SettingsThemeData(
          tileDescriptionTextColor: Theme.of(context).colorScheme.onPrimary,
        ),
        contentPadding: const EdgeInsets.only(top: 50),
        sections: [
          SettingsSection(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(AppLocalizations.of(context)!.settings,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal)),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                value: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      selected_local_hint,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 14.sp),
                    ),
                    items: locales
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selected_local,
                    onChanged: (value) {
                      if (value == 'العربية') {
                        locator<HiveService>()
                            .settings_box!
                            .put('locale', 'ar');
                      } else {
                        locator<HiveService>()
                            .settings_box!
                            .put('locale', 'en');
                      }

                      Phoenix.rebirth(context);
                    },
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                  ),
                ),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  if (value == true) {
                    locator<HiveService>().settings_box!.put('theme', 'dark');
                  } else {
                    locator<HiveService>().settings_box!.put('theme', 'light');
                  }

                  Phoenix.rebirth(context);
                },
                initialValue: is_darkmode,
                leading: Icon(Icons.dark_mode),
                title: Text(AppLocalizations.of(context)!.dark_mode),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.about_app),
                value: Text('فريق العمل \nفيصل فرج بوعجيلة'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
