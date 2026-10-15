import 'package:app/data/model/notificacao_model.dart';
import 'package:app/features/notificacao/repository/notificacao_repository.dart';
import 'package:app/features/notificacao/ui/notificacao_view.dart';
import 'package:app/features/notificacao/ui/notificacao_viewmodel.dart';
import 'package:app/features/notificacao/use_case/notificacao_usecase.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows notification data and its associated log', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificacaoView(
          viewModel: NotificacaoViewmodel(
            notificacaoUseCase: NotificacaoUseCase(notificacaoRepository: _FakeNotificacaoRepository()),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Falha ao processar solicitação'), findsOneWidget);
    expect(find.textContaining('ERROR'), findsOneWidget);
    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();
    expect(find.text('Log associado #17'), findsOneWidget);
    expect(find.text('Descrição: Falha no serviço'), findsOneWidget);
    expect(find.text('Detalhes do erro'), findsOneWidget);
  });

  testWidgets('shows empty state when there are no notifications', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificacaoView(
          viewModel: NotificacaoViewmodel(
            notificacaoUseCase: NotificacaoUseCase(notificacaoRepository: _EmptyNotificacaoRepository()),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Nenhuma notificação encontrada.'), findsOneWidget);
  });
}

class _FakeNotificacaoRepository implements NotificacaoRepository {
  @override
  Future<Result<List<NotificacaoModel>>> getNotificacoes() async {
    return Result.ok([
      NotificacaoModel.fromJson({
        'notiId': 5,
        'notiData': '2026-10-15T00:00:00.000Z',
        'notiTipo': 'ERROR',
        'notiTexto': 'Falha ao processar solicitação',
        'usuaId': 2,
        'logId': 17,
        'logTipo': 'ERROR',
        'logInfo': 'Detalhes do erro',
        'logTexto': 'Falha no serviço',
      }),
    ]);
  }
}

class _EmptyNotificacaoRepository implements NotificacaoRepository {
  @override
  Future<Result<List<NotificacaoModel>>> getNotificacoes() async => Result.ok([]);
}
