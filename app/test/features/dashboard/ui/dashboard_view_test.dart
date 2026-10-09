import 'package:app/features/dashboard/ui/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the dashboard without a navigation menu', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardView()));

    expect(find.text('Dashboard'), findsNWidgets(2));
    expect(find.byType(Drawer), findsNothing);
    expect(find.byTooltip('Open navigation menu'), findsNothing);
  });
}
