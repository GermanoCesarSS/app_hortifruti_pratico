import 'package:app_hortifruti_pratico/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('A função main inicializa o app e mostra a rota inicial',
      (WidgetTester tester) async {
    startApp();
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('DashboardPageScaffold')), findsOneWidget);
  });
}
