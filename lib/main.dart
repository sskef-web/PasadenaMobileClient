import 'package:pasadena_mobile_client/pages/authenticationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String appTitle = "Авторизация";
String baseURL = 'https://sskef.site/api/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('pl'), // Polish
          Locale('ru'), // Russian
        ],
        title: appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(17, 45, 48, 1)),
          useMaterial3: true,
          fontFamily: 'Exo2',
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(17, 45, 48, 1),
              brightness: Brightness.dark),
          useMaterial3: true,
          fontFamily: 'Exo2',
        ),
        home: const AuthenticationPage(),
      ),
    );
  }
}
