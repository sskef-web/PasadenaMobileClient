import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:pasadena_mobile_client/pages/authenticationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

String baseURL = 'https://sskef.site/api/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Exo2',
              colorScheme: ColorScheme.fromSeed(
                primary: Colors.white,
                surface: Colors.white,
                secondary: Colors.white,
                brightness: Brightness.light,
                seedColor: Colors.transparent,
                  primaryContainer: Colors.white,
                  dynamicSchemeVariant: DynamicSchemeVariant.neutral
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                primary: Colors.white,
                surface: Colors.white,
                secondary: Colors.white,
                brightness: Brightness.dark,
                seedColor: Colors.transparent,
                primaryContainer: Colors.white,
                  dynamicSchemeVariant: DynamicSchemeVariant.neutral
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