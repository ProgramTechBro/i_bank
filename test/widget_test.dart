import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_bank/config/app.dart';
import 'package:i_bank/config/app_constants.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.text(AppConstants.appName), findsOneWidget);
  });
}
