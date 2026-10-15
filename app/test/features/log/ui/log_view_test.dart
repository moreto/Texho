import 'package:app/data/model/log_model.dart';
import 'package:app/features/log/repository/log_repository.dart';
import 'package:app/features/log/ui/log_view.dart';
import 'package:app/features/log/ui/log_viewmodel.dart';
import 'package:app/features/log/use_case/log_usecase.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows logs returned by the API', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogView(
          viewModel: LogViewmodel(logUseCase: LogUseCase(logRepository: _FakeLogRepository())),
        ),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Falha no processamento'), findsOneWidget);
    expect(find.textContaining('ERROR'), findsOneWidget);
  });
}

class _FakeLogRepository implements LogRepository {
  @override
  Future<Result<List<LogModel>>> getLogs() async {
    return Result.ok([
      LogModel.fromJson({
        'logId': 1,
        'logTipo': 'ERROR',
        'logData': '2026-10-15T00:00:00.000Z',
        'logInfo': 'Detalhe do erro',
        'usuaId': 1,
        'logTexto': 'Falha no processamento',
      }),
    ]);
  }
}
