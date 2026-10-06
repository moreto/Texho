import 'package:app/features/script_teste/repository/script_teste_repository.dart';
import 'package:app/features/script_teste/ui/script_teste_view.dart';
import 'package:app/features/script_teste/ui/script_teste_viewmodel.dart';
import 'package:app/features/script_teste/use_case/script_teste_usecase.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeScriptTesteRepository implements ScriptTesteRepository {
  @override
  Future<Result<HealtModel>> healt() async => Result.ok(
    HealtModel(name: 'test', description: '', version: '', host: '', email: ''),
  );
}

void main() {
  testWidgets('shows the Script Teste screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScriptTesteView(
          viewModel: ScriptTesteViewmodel(
            useCase: ScriptTesteUseCase(repository: _FakeScriptTesteRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Script Teste'), findsNWidgets(2));
  });
}
