import 'package:app/features/notificacao/repository/notificacao_repository.dart';
import 'package:app/features/notificacao/ui/notificacao_view.dart';
import 'package:app/features/notificacao/ui/notificacao_viewmodel.dart';
import 'package:app/features/notificacao/use_case/notificacao_usecase.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNotificacaoRepository implements NotificacaoRepository {
  @override
  Future<Result<HealtModel>> healt() async => Result.ok(
    HealtModel(name: 'test', description: '', version: '', host: '', email: ''),
  );
}

void main() {
  testWidgets('shows the Notificacao screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificacaoView(
          viewModel: NotificacaoViewmodel(
            useCase: NotificacaoUseCase(repository: _FakeNotificacaoRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notificacao'), findsNWidgets(2));
  });
}
