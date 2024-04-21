import 'package:flutter/material.dart';

class AppLocalizations {
  static LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  final Map<String, String> _localizedStrings;

  AppLocalizations(this._localizedStrings);

  String? operator [](String key) => _localizedStrings[key];
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    Map<String, String> localizedStrings;
    if (locale.languageCode == 'ru') {
      localizedStrings = {
        'languageCode': 'ru',
        'news': 'Новости',
        'article': 'Статья',
        'apiLanguage': 'ru',
        'coffee': 'Кофе',
        'barista': 'Бариста',
        'sport': 'Спорт',
        'skiing': 'Лыжи',
        'music': 'Музыка',
        'favorites': 'Избранное',
        'to': "до",
        'from': "от"
      };
    } else {
      localizedStrings = {
        'languageCode': 'en',
        'news': 'News',
        'article': 'Article',
        'apiLanguage': 'en',
        'coffee': 'Coffee',
        'barista': 'Barista',
        'sport': 'Sport',
        'skiing': 'Skiing',
        'music': 'Music',
        'favorites': 'Favorites',
    'to': "to",
    'from': "from"
      };
    }
    return AppLocalizations(localizedStrings);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
