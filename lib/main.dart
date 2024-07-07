import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:pasadena_mobile_client/pages/authenticationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

String appTitle = "";
String baseURL = 'https://sskef.site/api/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(),
      child: Consumer<LanguageProvider>(
        builder: (_, languageProvider, __) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', ''), // Русский
              Locale('pl', ''), // Польский
              Locale('en', '')  // Английский
            ],
            locale: languageProvider.locale,
            title: appTitle,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Exo2',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark, seedColor: Colors.transparent,
              ),
              useMaterial3: true,
              fontFamily: 'Exo2',
            ),
            home: const AuthenticationPage(),
          );
        },
      ),
    );
  }
}