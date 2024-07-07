import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:pasadena_mobile_client/pages/authenticationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

String appTitle = "Авторизация";
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
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.transparent,
              ),
              useMaterial3: true,
              fontFamily: 'Exo2',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.transparent,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              fontFamily: 'Exo2',
            ),
            home: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(1, 17, 45, 48),
                    Color.fromARGB(1, 17, 45, 48),
                    Color.fromARGB(1, 4, 79, 75),
                    Color.fromARGB(1, 1, 86, 81),
                  ],
                  stops: [0.03, 0.27, 0.86, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              ),
              child: const AuthenticationPage(),
            ),
          );
        },
      ),
    );
  }
}