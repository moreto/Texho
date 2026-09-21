import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/providers.dart';
import 'config/theme_controller.dart';
import 'routing/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: configProviders(),
      child: Consumer<ThemeModeController>(
        builder: (context, themeController, child) {
          return MaterialApp.router(
            // scrollBehavior: AppCustomScrollBehavior(),
            theme: AppTheme.lightTheme(font: themeController.font),
            darkTheme: AppTheme.darkTheme(font: themeController.font),
            themeMode: themeController.mode,
            routerConfig: router(),
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            // locale: localeModel.locale,
          );
        },
      ),
    );
  }
}
