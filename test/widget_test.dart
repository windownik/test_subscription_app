import 'package:flutter_test/flutter_test.dart';
import 'package:test_payment_app/app.dart';

void main() {
  testWidgets('shows welcome onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to app'), findsOneWidget);
  });
}
