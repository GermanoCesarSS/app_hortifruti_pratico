import 'package:app_hortifruti_pratico/app/core/theme/app_theme.dart';
import 'package:app_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_hortifruti_pratico/app/routes/pages.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  startApp();
}

void startApp() {
  Intl.defaultLocale = 'pt_BR';
  Get.put<Api>(Api());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.dashboard,
    theme: themeData,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [
      Locale('pt', 'BR'),
    ],
  ));
}
