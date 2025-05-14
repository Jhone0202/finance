import 'package:finance/home/components/home_body_data.dart';
import 'package:finance/home/controllers/home_controller.dart';
import 'package:finance/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../mocks/fake_transactions_repository.dart';

void main() {
  testWidgets('should display a CircularProgressIndicator when data is loading',
      (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => HomeController(FakeRepository())..load()),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display a HomeBodyData when data is done',
      (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => HomeController(FakeRepository())..load()),
        ],
        child: const MaterialApp(
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: <Locale>[Locale('pt', 'BR')],
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(HomeBodyData), findsOneWidget);
  });
}
