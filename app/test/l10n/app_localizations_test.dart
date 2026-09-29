import 'package:app/data/model/traducao_model.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocalizations', () {
    test('uses repository translations by their Portuguese value', () {
      final localizations = AppLocalizations(
        locale: const Locale('es', 'ES'),
        translations: [TraducaoModel(tradChave: 'email', tradPtBr: 'eMail', tradEsEs: 'Correo', tradEnUs: 'Email')],
      );

      expect(localizations.translate('eMail'), 'Correo');
    });

    test('returns the original key when the repository field for the locale is empty', () {
      final localizations = AppLocalizations(
        locale: const Locale('en', 'US'),
        translations: [
          TraducaoModel(tradChave: 'informeEmail', tradPtBr: 'Informe o eMail', tradEsEs: '', tradEnUs: ''),
        ],
      );

      expect(localizations.translate('Informe o eMail'), 'Informe o eMail');
    });

    test('returns the original view key when it has no translation', () {
      final localizations = AppLocalizations(locale: const Locale('en', 'US'), translations: const []);

      expect(localizations.translate('Unknown label'), 'Unknown label');
    });
  });
}
