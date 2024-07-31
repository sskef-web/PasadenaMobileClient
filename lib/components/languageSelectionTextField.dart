import 'package:flutter/material.dart';
import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectionTextField extends StatefulWidget {
  const LanguageSelectionTextField({Key? key});

  @override
  _LanguageSelectionTextFieldState createState() => _LanguageSelectionTextFieldState();
}

class _LanguageSelectionTextFieldState extends State<LanguageSelectionTextField> {
  Locale? selectedLocale;
  String _nowLocale = 'RU';

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromRGBO(168, 168, 168, 1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.appLanguage,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(17, 45, 48, 1),
                  ),
                ),
                DropdownButton<Locale>(
                  value: selectedLocale,
                  onChanged: (Locale? newValue) {
                    setState(() {
                      selectedLocale = newValue;
                      switch (selectedLocale) {
                        case 'ru':
                          _nowLocale = 'RU';
                          break;
                        case 'pl':
                          _nowLocale = 'PL';
                          break;
                        case 'en':
                          _nowLocale = 'EN';
                          break;
                        default:
                          _nowLocale = 'PL';
                      }
                    });
                    languageProvider.changeLanguage(newValue!);
                  },
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem<Locale>(
                      value: Locale('ru'),
                      child: Text(
                        'RU',
                        style: TextStyle(
                          color: Color.fromRGBO(168, 168, 168, 1),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('pl'),
                      child: Text(
                        'PL',
                        style: TextStyle(
                          color: Color.fromRGBO(168, 168, 168, 1),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('en'),
                      child: Text(
                        'EN',
                        style: TextStyle(
                          color: Color.fromRGBO(168, 168, 168, 1),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                  hint: Text(
                    Localizations.localeOf(context).languageCode.toUpperCase(),
                    style: const TextStyle(
                      color: Color.fromRGBO(168, 168, 168, 1),
                      fontSize: 16.0,
                    ),
                  ),
                  isExpanded: false,
                  underline: const SizedBox(),
                  style: const TextStyle(fontSize: 16.0),
                  selectedItemBuilder: (BuildContext context) {
                    return [
                      const DropdownMenuItem<Locale>(
                        value: Locale('ru'),
                        child: Text(
                          'RU',
                          style: TextStyle(
                            color: Color.fromRGBO(168, 168, 168, 1),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const DropdownMenuItem<Locale>(
                        value: Locale('pl'),
                        child: Text(
                          'PL',
                          style: TextStyle(
                            color: Color.fromRGBO(168, 168, 168, 1),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const DropdownMenuItem<Locale>(
                        value: Locale('en'),
                        child: Text(
                          'EN',
                          style: TextStyle(
                            color: Color.fromRGBO(168, 168, 168, 1),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ];
                  }, icon: const Icon(Icons.arrow_drop_down, color: Color.fromRGBO(168, 168, 168, 1),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}