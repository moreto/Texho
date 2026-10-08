import 'package:app/features/dashboard/repository/dashboard_repository.dart';
import 'package:app/features/dashboard/ui/dashboard_view.dart';
import 'package:app/features/dashboard/ui/dashboard_viewmodel.dart';
import 'package:app/features/dashboard/use_case/dashboard_usecase.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDashboardRepository implements DashboardRepository {
  @override
  Future<Result<HealtModel>> healt() async => Result.ok(
    HealtModel(name: 'test', description: '', version: '', host: '', email: ''),
  );
}

void main() {
  testWidgets('shows the Dashboard screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardView(
          viewModel: DashboardViewmodel(
            useCase: DashboardUseCase(repository: _FakeDashboardRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsNWidgets(2));
  });
}
