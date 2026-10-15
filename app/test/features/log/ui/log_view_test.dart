import 'package:app/config/dependencies.dart';
import 'package:app/features/log/repository/log_repository.dart';
import 'package:app/features/log/ui/log_view.dart';
import 'package:app/features/log/ui/log_viewmodel.dart';
import 'package:app/features/log/use_case/log_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Log screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogView(
          viewModel: LogViewmodel(logUseCase: LogUseCase(logRepository: locator<LogRepository>())),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Log'), findsNWidgets(2));
  });
}
