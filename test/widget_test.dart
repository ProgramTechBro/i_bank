import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_bank/config/app.dart';

void main() {
  testWidgets('App renders the splash screen without crashing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pump();

    expect(find.byType(Scaffold), findsWidgets);

    await tester.pump(const Duration(seconds: 3));
  });
}
