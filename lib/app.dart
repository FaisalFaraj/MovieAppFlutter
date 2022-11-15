import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

import 'core/services/hive/hive_service.dart';
import 'locator.dart';
import 'ui/router.gr.dart';
import 'ui/shared/themes.dart';

Future<Widget> initializeApp() async {
  return MyApp();
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp();

  final _appRouter = AppRouter();

  ThemeData current_theme = ThemeData();
  ThemeMode? theme_mode;
  @override
  Widget build(BuildContext context) {
    if (locator<HiveService>().settings_box!.get('locale') == null) {
      locator<HiveService>()
          .settings_box!
          .put('locale', ui.window.locale.languageCode);
    }

    if (locator<HiveService>().settings_box!.get('theme') == null) {
      locator<HiveService>().settings_box!.put('theme', 'light');
    }

    if (locator<HiveService>().settings_box!.get('theme') == 'light') {
      current_theme = AppThemes.lightTheme;
      theme_mode = ThemeMode.light;
    } else if (locator<HiveService>().settings_box!.get('theme') == 'dark') {
      current_theme = AppThemes.darkTheme;
      theme_mode = ThemeMode.dark;
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        theme: current_theme,
        darkTheme: AppThemes.darkTheme,
        themeMode: theme_mode,
        locale: Locale(locator<HiveService>().settings_box!.get('locale'), ''),
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ar', ''), // Arabic, no country code
        ],
        // localeResolutionCallback: (deviceLocale, supportedLocales) {
        //   //myLocale = deviceLocale ; // here you make your app language similar to device language , but you should check whether the localization is supported by your app
        // },
        onGenerateTitle: (context) => '',
      );
    });
  }
}
