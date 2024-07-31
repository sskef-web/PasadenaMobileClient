import 'package:flutter/material.dart';
import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelectionButton extends StatefulWidget {
  const LanguageSelectionButton({super.key});

  @override
  _LanguageSelectionButtonState createState() => _LanguageSelectionButtonState();
}

class _LanguageSelectionButtonState extends State<LanguageSelectionButton> {
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
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 215, 0, 1.0),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center (
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<Locale>(
            value: selectedLocale,
            onChanged: (Locale? newValue) {
              setState(() {
                selectedLocale = newValue;
                switch (selectedLocale!.languageCode) {
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
            items: const [
              DropdownMenuItem<Locale>(
                value: Locale('ru'),
                child: Text(
                  'RU',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 215, 0, 1.0),
                    fontSize: 16.0,
                  ),
                ),
              ),
              DropdownMenuItem<Locale>(
                value: Locale('pl'),
                child: Text(
                  'PL',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 215, 0, 1.0),
                    fontSize: 16.0,
                  ),
                ),
              ),
              DropdownMenuItem<Locale>(
                value: Locale('en'),
                child: Text(
                  'EN',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 215, 0, 1.0),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
            hint: Text(
              Localizations.localeOf(context).languageCode.toUpperCase(),
              style: const TextStyle(
                color: Color.fromRGBO(255, 215, 0, 1.0),
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
                      color: Color.fromRGBO(255, 215, 0, 1.0),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const DropdownMenuItem<Locale>(
                  value: Locale('pl'),
                  child: Text(
                    'PL',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 215, 0, 1.0),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const DropdownMenuItem<Locale>(
                  value: Locale('en'),
                  child: Text(
                    'EN',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 215, 0, 1.0),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}