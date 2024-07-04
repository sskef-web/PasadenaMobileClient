import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pasadena_mobile_client/data/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectLanguage),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            _buildLanguageButton(
              context,
              languageProvider,
              const Locale('ru'),
              'Русский',
            ),
            const SizedBox(height: 16),
            _buildLanguageButton(
              context,
              languageProvider,
              const Locale('pl'),
              'Polski',
            ),
            const SizedBox(height: 16),
            _buildLanguageButton(
              context,
              languageProvider,
              const Locale('en'),
              'English',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    LanguageProvider languageProvider,
    Locale locale,
    String languageName,
  ) {
    return ElevatedButton(
      onPressed: () {
        languageProvider.changeLanguage(locale);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        languageName,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
